
clear all ;
filePath1 = "/Users/eytanrozenblum/Desktop/1. Academic/Bac+3-Bac+5/2. Polytechnique/1. M2/2. S2/Econometrics Project/1. Database/GSS_IJCB_DataCode/tightalldata.txt"
X = readtable(filePath1) ;
% columns are:  mo, dy, yr, mp1, mp2,
%		ed1, ed2, ed3, ed4, 3m,
%		6m, 2y, 5y, 10y, 30y,
%		fwd, sp500, statedum.

%X = tightalldata(19:end,[10:14,17]) ; % Treasuries and stocks, drop NaNs pre-91
X = tightalldata(47:end,[7 9 12 14 17]) ; % Treasuries and stocks, start 1994
%X = tightalldata(:,[4:5,7:9]) ; % mp1, mp2, ed2, ed3, ed4

%X = X([1:86,88:end],:) ; % drop 1/3/2001 observation (in row 87), if desired


ranktest(X) ;

