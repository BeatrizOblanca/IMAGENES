%% PRIMERA PRÁCTICA
% GP_IB

im1 = imread('Tema1-T1-XRay.jpg');  %Leer la imagen
imshow(im1);                        %para mostrar la imagen 
size(im1)                           %averiguamos el tamaño de la imágen
max(max(im1))                       %para saber el valor máximo de luminancia/brillo
%%
max(im1)        %si ponemos así calcula el máximo de las columnas
max(im1(:))     %así tenemos el máximo de toda la matriz
%% 
% Tenemos que tener en cuenta que matlab ordena por columnas, es decir que va 
% poniendo una columna debajo de otra

 min(min(im1))  %la imágen tiene el máximo contraste, porque el mínimo es 0 y el máximo 255
%% Formatos de Imagen de Escala de Grises
% Matlab siempre usa precisión 2 por defecto

 im2 = im2double(im1);%convierto la imágen original en double
%% 
% Al pasar a double, pasamos a real y divide entre 255, por lo que nos quedan 
% los mismos valores pero entre 0-1

 imshow(im2);
 imshow(im2/2); %ahora el rango queda entre 0-127/128
%% 
% El formato jpg comprime con pérdidas la imágen, por lo que no suele utilizarse 
% en el ámbito sanitario
%% Imágen en color

im3 = imread('Tema1-T1-Histology.jpg'); 
imshow(im3); %esta imagen tiene 3 capas, por lo que estamos trabajando con una imágen a color
%Ahora separamos de las capas de la imagen
R = im3(:,:,1);
G = im3(:,:,2);
B = im3(:,:,3);
figure;imshow(R);title('Componente roja.');
figure;imshow(G);title('Componente verde.');
figure;imshow(B);title('Componente azul.'); 
R2 = R;
R2 (:,:,2) = 0;
R2 (:,:,3) = 0;
imshow(R2);
%%
im4 = im2double(im3);   % Toda la imagen
r = im2double(R);
g = im2double(G);
b = im2double(B);       % Componente a componente 
imshow(im4/2);
%% EJERCICIOS
% A) Visualización de Componentes RGB: 
% Recuerda: las funciones siempre tienen que ir al final
% 
% Para poder hacer concatenación de matrices es necesario que tengan las mismas 
% dimensiones

imcomp=VisualizaComponentes(im3);
imcomp2=VisualizaComponentes2(im3);
% B) Calcular Componentes R, G y B de un Punto:

[R,G,B] = ComponentesPunto(im3,20,56)
% C) Convertir Imagen RGB en Escala de Grises: 

imbn = ImagenGrises(im3);
%Ahora usamos la función propia de matlab
im3_2= rgb2gray(im3);
imshow(im3_2)
% D) Hacer el Negativo de una Imagen RGB:

subplot(1,2,1);imshow(NegativoGrises(im1));
subplot(1,2,1);imshow(NegativoGrises(im2));
% E) Intercambiar dos Planos de una Imagen RGB:

imc2=SwapRB(im3);
% F) Aumentar una Imagen hasta el máximo Contraste:

imc3 = maxcontraste(im1);
%% 
% Función

function img_comp = VisualizaComponentes(imc)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                           %
    % Funcion que visualiza componentes (R,G,B) %
    % en su color original.                     %
    %                                           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imR = imc;
    imG = imc;
    imB = imc;                         % Inicio
    imR(:,:,[2 3]) = 0;                % Parte roja
    imG(:,:,[1 3]) = 0;                % Parte verde
    imB(:,:,[1 2]) = 0;                % Parte azul
    img_comp = [imc imR imG imB];      % Concatenar imagenes
    imshow(img_comp);                  % Display
end

function img_comp2 = VisualizaComponentes2(imc)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                           %
    % Funcion que visualiza componentes (R,G,B) %
    % en su color original.                     %
    %                                           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imR = imc;
    imG = imc;
    imB = imc;                         % Inicio
    imR(:,:,[2 3]) = 0;                % Parte roja
    imG(:,:,[1 3]) = 0;                % Parte verde
    imB(:,:,[1 2]) = 0;                % Parte azul
    img_comp2 = [imc; imR; imG; imB];  %para que aparezca como columna
    imshow(img_comp2);
end

function [R,G,B] = ComponentesPunto(imc,x,y)
    R = imc(x,y,1);
    G = imc(x,y,2);
    B = imc(x,y,3);
end

function imbn = ImagenGrises(imc)
    R = imc(:,:,1);
    G = imc(:,:,2);
    B = imc(:,:,3);
    imbn = 0.3*R+0.59*G+0.11*B;
    imshow(imbn)
end

function imneg = NegativoGrises(im) %isfloat es una función lógica 1=real 0 no real
   flag =  isfloat(im);
   if(flag)
       imneg= 1.0-im;
   else
       imneg = uint8(255)-im;
   end
end

function imc2 = SwapRB(imc)
    imc2 = imc(:,:,[3,2,1]);%cambiamos el orden
    imshow(imc2)
end

function [M,m,maxcont] = maxcontraste(imc)
    M = max(imc(:));%calculamos el valor máximo de contraste
    m = min(imc(:));%calculamos el valor mínimo de contraste
    min_Y = 0;%ahora igualamos el nuevo mínimo a 0 sin importar el tipo de imagen
    if isfloat(M)%valoramos si es unit8 o double
        max_Y = 1;
    else
        max_Y = 255;
    end
    maxcont = ((imc-m)/(M-m))*max_Y+min_Y;
    imshow(maxcont);
end