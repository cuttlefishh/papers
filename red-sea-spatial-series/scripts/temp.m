fluMax = max(fluCol);
for k = 1:655000
    fluCol(k) = fluCol(k) + fluMax;
end