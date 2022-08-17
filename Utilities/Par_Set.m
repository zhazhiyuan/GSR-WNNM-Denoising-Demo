function par  =  Par_Set( nSig, I,  gamma, lamada, c1 )

par.I                =      double(I);

par.nSig            =       nSig;

par.Iter             =       30;


par.step             =        4;


if nSig <=20

par.c                =        c1;  

par.w                =        gamma;   

par.lamada           =        lamada; 


par.win              =        6;

par.nblk             =        60;


par.diff             =        0.0013;




elseif nSig <=30

par.c                =        c1;  

par.w                =        gamma;   

par.lamada           =        lamada; 



par.win              =         7;

par.nblk             =         60;

par.diff             =        0.0010;




elseif nSig <=40

par.c                =        c1;  

par.w                =        gamma;   

par.lamada           =        lamada; 


par.win              =         7;

par.nblk             =         60;

par.diff             =        0.0012;

elseif nSig <=50

par.c                =        c1;  

par.w                =        gamma;   

par.lamada           =        lamada; 



par.win              =         8;

par.nblk             =         70;

par.diff             =        0.0013;





elseif nSig <=75

par.c                =        c1;  

par.w                =        gamma;   

par.lamada           =        lamada; 



par.win              =         8;

par.nblk             =         80;


par.diff             =       0.0017;

else
    
par.c                =        c1;  

par.w                =        gamma;   

par.lamada           =        lamada; 


par.win              =         9;

par.nblk             =         100;

par.diff             =        0.0019;
end

end

