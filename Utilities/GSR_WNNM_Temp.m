function  X   =   GSR_WNNM_Temp( Y, c1, nsig, mB)



[GR_S, Sigma0, GR_D] = svd(full(Y),'econ');  


Sigma0            =   diag(Sigma0); 

S                 =   max( Sigma0.^2/size(Y, 2) - nsig^2, 0 );
thr               =   c1*sqrt(2)*nsig^2./ ( sqrt(S) + eps );
S                 =   soft(Sigma0, thr);
X                 =    GR_S*diag(S)*GR_D';
X                 =    X + mB;

return;