
% Decryption Function-Diffusion processs - Mandelbrotset + Arnold map
%--------------------------------------------------------------------------------------------------------------------------------------
function k=Decry_DMA(p,q,s,siz)
%--------------------------------------------------------------------------------------------------------------------------------------
% DEMO:
% a=imread('cipher.png'); % Input cipher your image 

% Decompose in to R,G,B 
% R=a(:,:,1);
% G=a(:,:,2);
% B=a(:,:,3);
% siz=size(R);
% siz=siz(1);
% ro=siz*siz;
%--------------------------------------------------------------------------------------------------------------------------------------
% Input your R,G,B components 
  R=p ;
  G=q ;
  B=s;
  ro=siz*siz;
  
  
% Reshape in to ID matrix:
    R = reshape(R,[1,ro]);
    G = reshape(G,[1,ro]);
    B = reshape(B,[1,ro]);
    
    r=double(R);
    g=double(G);
    b=double(B);
%--------------------------------------------------------------------------------------------------------------------------------------      
% Calling Modified  Mandelbrotset fuction with initial values
% you can change the initail values to your own 
%--------------------------------------------------------------------------------------------------------------------------------------   
    mds1=md(27,siz);
    mds2=md(29,siz);
    mds3=md(31,siz);
 
% Reshape into ID matrix:
    mds1= reshape(mds1,[1,ro]);  
    mds2= reshape(mds2,[1,ro]); 
    mds3= reshape(mds3,[1,ro]); 
%--------------------------------------------------------------------------------------------------------------------------------------
% Calling Arnold map fuction with initial values 
% you can change the initail values to your own 
%--------------------------------------------------------------------------------------------------------------------------------------    
    aR=arnold(ini,ini,siz);
  
% Normalizing the arnoldmap values to 256
    S1=mod((aR*(10.^10)),256);
  
% Reshape in to ID matrix:
    S1= reshape(S1,[1,ro]);
    S1=uint8(S1);
%--------------------------------------------------------------------------------------------------------------------------------------   
% Performing XOR operation on mandelbrotset and Arnold map
%--------------------------------------------------------------------------------------------------------------------------------------   
   for i=1:ro
      rn1(i)=mod(((bitxor((mds1(i)),(S1(i))))),256);
      gn1(i)=mod(((bitxor((mds2(i)),(S1(i))))),256);
      bn1(i)=mod(((bitxor((mds3(i)),(S1(i))))),256);
   end
%--------------------------------------------------------------------------------------------------------------------------------------       
% Performing XOR operation on R,G,B, components with previous output
%--------------------------------------------------------------------------------------------------------------------------------------
 for i=1:ro
        r11(i)=mod((bitxor(r(i),rn1(i))),256);
        g11(i)=mod((bitxor(g(i),gn1(i))),256);
        b11(i)=mod((bitxor(b(i),gn1(i))),256);
   end
%--------------------------------------------------------------------------------------------------------------------------------------   
% Reshape in to 2D matrix:
    tp = reshape(r11,[siz,siz]);
    tq = reshape(g11,[siz,siz]);
    ts = reshape(b11,[siz,siz]);
    
% concatenate Decrypted R,G,B
      k=cat(3,tp,tq,ts);
      figure;
      imshow(k);title('Decrypted image');
% Finding entropy of an Decrypted Output
       entropy(k)
%--------------------------------------------------------------------------------------------------------------------------------------
end
