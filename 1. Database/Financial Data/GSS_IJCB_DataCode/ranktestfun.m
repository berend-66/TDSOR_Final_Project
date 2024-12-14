function out = ranktestfun(theta,vecsigma,Vhat) ;

[r,k] = size(theta) ; % note that the rank being tested is r0 = r-1

sigmamat = diag(theta(1,:).^2) + theta(2:r,:)'*theta(2:r,:) ;

tempsigma = sigmamat(find(tril(ones(size(sigmamat))))) ;

out = (vecsigma -tempsigma)' /Vhat *(vecsigma -tempsigma) ;
