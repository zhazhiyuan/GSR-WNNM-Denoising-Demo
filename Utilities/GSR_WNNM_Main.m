function [filename, Sigma, PSNR_Final,FSIM_Final,SSIM_Final ]     =  GSR_WNNM_Main (filename, Sigma, gamma, lamada, c1)

randn ('seed',0);

fn               =     [filename, '.tif'];

I                =     imread(fn);

[~, ~, kk]       =     size (I);

if kk==3
    
    I     = rgb2gray (I);
       
end


par              =    Par_Set (Sigma, I, gamma, lamada, c1);

par.nim          =    par.I + par.nSig* randn(size( par.I ));

disp(sprintf('PSNR of the noisy image = %f \n', csnr(par.nim, par.I, 0, 0) ));


[Denoising , dif, iter]              =    GSR_WNNM_Denoising( par);

im  = Denoising{iter-1};


PSNR_Final       =   csnr (im, par.I,0,0);
FSIM_Final       =   FeatureSIM(im, par.I);
SSIM_Final       =   cal_ssim (im, par.I,0,0);



if Sigma==10

Final_denoisng= strcat(filename,'GSR_WNNM_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_SSIM_',num2str(SSIM_Final),'_FSIM_',num2str(FSIM_Final),'.png');

imwrite(uint8(im),strcat('./10_Result/',Final_denoisng));


elseif Sigma==20

Final_denoisng= strcat(filename,'GSR_WNNM_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_SSIM_',num2str(SSIM_Final),'_FSIM_',num2str(FSIM_Final),'.png');

imwrite(uint8(im),strcat('./20_Result/',Final_denoisng));

elseif Sigma==30
    
Final_denoisng= strcat(filename,'GSR_WNNM_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_SSIM_',num2str(SSIM_Final),'_FSIM_',num2str(FSIM_Final),'.png');
imwrite(uint8(im),strcat('./30_Result/',Final_denoisng));

elseif Sigma==40
    
Final_denoisng= strcat(filename,'GSR_WNNM_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_SSIM_',num2str(SSIM_Final),'_FSIM_',num2str(FSIM_Final),'.png');

imwrite(uint8(im),strcat('./40_Result/',Final_denoisng));

elseif Sigma==50
    
Final_denoisng= strcat(filename,'GSR_WNNM_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_SSIM_',num2str(SSIM_Final),'_FSIM_',num2str(FSIM_Final),'.png');
imwrite(uint8(im),strcat('./50_Result/',Final_denoisng));

elseif Sigma==75
    
Final_denoisng= strcat(filename,'GSR_WNNM_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_SSIM_',num2str(SSIM_Final),'_FSIM_',num2str(FSIM_Final),'.png');

imwrite(uint8(im),strcat('./75_Result/',Final_denoisng));

else
    
Final_denoisng= strcat(filename,'GSR_WNNM_','_sigma_',num2str(Sigma),'_PSNR_',num2str(PSNR_Final),'_SSIM_',num2str(SSIM_Final),'_FSIM_',num2str(FSIM_Final),'.png');

imwrite(uint8(im),strcat('./100_Result/',Final_denoisng));
end


end

