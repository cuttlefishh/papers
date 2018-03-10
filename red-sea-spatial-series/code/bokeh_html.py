#!/usr/bin/env python
import pandas as pd
import click
from bokeh.io import vform
from bokeh.plotting import figure, show, output_file
from bokeh.models import CustomJS, ColumnDataSource
from bokeh.models.widgets import Select
from bokeh.palettes import (Blues9, BrBG9, BuGn9, BuPu9, GnBu9, Greens9,
                            Greys9, OrRd9, Oranges9, PRGn9, PiYG9, PuBu9,
                            PuBuGn9, PuOr9, PuRd9, Purples9, RdBu9, RdGy9,
                            RdPu9, RdYlBu9, RdYlGn9, Reds9, Spectral9, YlGn9,
                            YlGnBu9, YlOrBr9, YlOrRd9)
standard_palettes = dict([("Blues", Blues9), ("BrBG", BrBG9),
                          ("BuGn", BuGn9), ("BuPu", BuPu9),
                          ("GnBu", GnBu9), ("Greens", Greens9),
                          ("Greys", Greys9), ("OrRd", OrRd9),
                          ("Oranges", Oranges9), ("PRGn", PRGn9),
                          ("PiYG", PiYG9), ("PuBu", PuBu9),
                          ("PuBuGn", PuBuGn9), ("PuOr", PuOr9),
                          ("PuRd", PuRd9), ("Purples", Purples9),
                          ("RdBu", RdBu9), ("RdGy", RdGy9),
                          ("RdPu", RdPu9), ("RdYlBu", RdYlBu9),
                          ("RdYlGn", RdYlGn9), ("Reds", Reds9),
                          ("Spectral", Spectral9), ("YlGn", YlGn9),
                          ("YlGnBu", YlGnBu9), ("YlOrBr", YlOrBr9),
                          ("YlOrRd", YlOrRd9)])
@click.command()
@click.option('--input_fp', '-i', type=click.Path(
              exists=True, dir_okay=False, readable=True, resolve_path=True),
              help='Input metadata file')
@click.option('--output_fp', '-o', type=click.Path(
              dir_okay=False, writable=True, resolve_path=True),
              help='Output filepath')
@click.option('--title', '-t', type=str, help='Title of the graph')
@click.option('--seperator', '-s', required=False, type=str, default=',',
              help='Seperator on the file (Default ",")')
@click.option('--color_by', '-c', required=False, type=str,
              help='Column name to color the data by (Default None)')
@click.option('--palette', '-p', required=False,
              help='Color palette to use, or string in the form '
              'group1:color,group2:color\n'
              'Possible palletes:\n' + ', '.join(standard_palettes.keys()))
@click.option('--legend_pos', '-l', required=False, default='top_right',
              type=click.Choice(
                  ['top_right', 'top_left', 'bottom_right', 'bottom_left']),
              help='Seperator on the file (Default ",")')
@click.argument('remcols', nargs=-1, type=str)
def build_bokeh(input_fp, output_fp, title, seperator=',', remcols=None,
                color_by=None, palette=None, legend_pos='top_right'):
    data = pd.DataFrame.from_csv(input_fp, sep=seperator)
    # Put depth as first column
    cols = data.columns.tolist()
    popped = cols.pop(7)
    cols.insert(0, popped)
    data = data[cols]
    # Change odd depths to regular ones
    data['Depth (m)'].replace(47, 50, inplace=True)
    #data['Depth (m)'].replace(258, 200, inplace=True)
    # Drop unwanted columns if needed
    if remcols:
        remcols = list(remcols)
        data.drop(remcols, axis=1, inplace=True)
    # Build out the colors for the graph if needed
    legend = []
    if color_by is not None:
        groups = data.groupby(color_by).groups
        group_list = sorted(groups.keys(), reverse=True)
        # Grab colormap or use provided
        if len(palette.split(',')) > 1:
            # Format into colormap-like object
            p = palette.split(',')
            hold = dict(x.split(':') for x in p)
            colormap = [hold[str(g)] for g in group_list]
        elif len(groups) > 9:
                raise ValueError("Can only support up to 9 groups, "
                                 "%s has %d groups" % color_by, len(groups))
        else:
            colormap = standard_palettes[palette]
        # Build colormap
        index = []
        colors = []
        for group_num, group in enumerate(group_list):
            vals = groups[group]
            index.extend(vals)
            colors.extend([colormap[group_num]] * len(vals))
            # build legend colors list
            legend.append((str(group), colormap[group_num]))
        data['colormap'] = pd.Series(colors, index=index)
    # Build the actual graph page
    source = ColumnDataSource(data=data)
    callback = CustomJS(args=dict(source=source), code="""
        var data = source.get('data');
        var title = cb_obj.get('title');
        var value = cb_obj.get('value');
        if(title == "X-axis:") {
          data['x'] = data[value];
        } else {
          data['y'] = data[value];
        }
        source.trigger('change');
    """)
    select_x = Select(title="X-axis:", value=data.columns[0],
                      options=list(data.columns), callback=callback)
    select_y = Select(title="Y-axis:", value=data.columns[0],
                      options=list(data.columns), callback=callback)
    output_file(output_fp, title=title)
    p = figure(title=title)
    p.xaxis.axis_label = 'X-axis'
    p.yaxis.axis_label = 'Y-axis'
    # Create graph itself, with colormap and color legend if needed
    if color_by is not None:
        p.circle(x=data[data.columns[0]], y=data[data.columns[0]], size=10,
                 source=source, legend=False, color=data['colormap'],
                 fill_alpha=0, line_width=2)
        # Add legend spots
        for title, color in legend[::-1]:
            p.circle(x=[], y=[], size=10, color=color, legend=title,
                     fill_alpha=0, line_width=2)
        p.legend.orientation = legend_pos
    else:
        p.circle(x=data[data.columns[0]], y=data[data.columns[0]], size=10,
                 source=source, legend=False, fill_alpha=0, line_width=2)
    layout = vform(p, select_x, select_y)
    show(layout)
if __name__ == "__main__":
    build_bokeh()
