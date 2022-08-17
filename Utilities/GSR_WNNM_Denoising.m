
function [Denoising , difff, iter]    =  GSR_WNNM_Denoising( par)

randn ('seed',0);

Nim                =   par.nim;

Ori_im             =   par.I;

b                  =   par.win;

[h, w, ch]         =   size(Nim);

N                  =   h-b+1;

M                  =   w-b+1;

r                  =   [1:N];

c                  =   [1:M]; 

%disp(sprintf('PSNR of the noisy image = %f \n', csnr(Nim, Ori_im, 0, 0) ));

Im_Out      =   Nim;


lamada      =   par.w;

nsig        =   par.nSig;

m           =   par.nblk;

cnt         =   1;

AllPSNR     =  zeros(1,par.Iter );

Denoising  =   cell (1,par.Iter);

for iter = 1 : par.Iter    
    
            Im_Out               =   Im_Out + lamada*(Nim - Im_Out);
        
            dif                  =   Im_Out-Nim;
        
            vd                   =      nsig^2-(mean(mean(dif.^2)));
        
       if iter==1
            
            par.nSig             =         sqrt(abs(vd)); 

       else
            
             par.nSig            =         sqrt(abs(vd))*par.lamada;
            
       end 
            
        



              blk_arr           =          Block_matching( Im_Out, par);  

       
      
        X                       =         Im2Patch( Im_Out, par );  
        
        Ys                      =         zeros( size(X) );    
        
        W                       =         zeros( size(X) );
        
        K                       =         size(blk_arr,2);
           
    
        
        for  i  =  1 : K  
            
            

             B                  =         X(:, blk_arr(:, i));  
             
             mB                 =         repmat(mean( B, 2 ), 1, size(B, 2));
             
             B                  =         B-mB;   

            TMP                 =          GSR_WNNM_Temp( double(B), par.c, par.nSig, mB); %Core
           
       Ys(:, blk_arr(1:m,i))    =          Ys(:, blk_arr(1:m,i)) + TMP;
       
       W(:, blk_arr(1:m,i))     =          W(:, blk_arr(1:m,i)) + 1;
             
         end

        Im_Out   =  zeros(h,w);
        
        im_wei   =  zeros(h,w);
        
        k        =   0;
        
        for i  = 1:b
            for j  = 1:b
                k    =  k+1;
                Im_Out(r-1+i,c-1+j)  =  Im_Out(r-1+i,c-1+j) + reshape( Ys(k,:)', [N M]);
                im_wei(r-1+i,c-1+j)  =  im_wei(r-1+i,c-1+j) + reshape( W(k,:)',  [N M]);
            end
        end
        
        Im_Out  =  Im_Out./(im_wei+eps);
        
        Denoising{iter}  =   Im_Out;

        AllPSNR(iter)  = csnr( Im_Out, par.I, 0, 1 );
              
        fprintf( 'Iteration %d :PSNR = %f\n', cnt,  csnr( Im_Out, par.I, 0, 1) );
        
        cnt   =  cnt + 1;

   if iter>1
       
     difff      =  norm(abs(Denoising{iter}) - abs(Denoising{iter-1}),'fro')/norm(abs(Denoising{iter-1}), 'fro');
     
       if difff<par.diff 
           break;
       end    
   end    
   
end
im      =      Denoising{iter-1};

disp(sprintf('PSNR of the Denoised image = %f \n', csnr(im, Ori_im, 0, 0) ));

return;




