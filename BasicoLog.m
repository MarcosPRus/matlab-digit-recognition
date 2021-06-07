%% Entrenamiento
%Calculamos los momentos de Hu de orden 1, 2, 3, 4 y los
%normalizamos entre 0 y 1.
%Hu_ord1_, Hu_ord2_, Hu_ord3_, Hu_ord4_
%Calculamos los 4 primeros momentos de Hu para cada dígito
Hu0 = moments('Imagenes/0.png');
Hu1 = moments('Imagenes/1.png');
Hu2 = moments('Imagenes/2.png');
Hu3 = moments('Imagenes/3.png');
Hu4 = moments('Imagenes/4.png');
Hu5 = moments('Imagenes/5.png');
Hu6 = moments('Imagenes/6.png');
Hu7 = moments('Imagenes/7.png');
Hu8 = moments('Imagenes/8.png');
Hu9 = moments('Imagenes/9.png');

Hu = cat(3,Hu0,Hu1,Hu2,Hu3,Hu4,Hu5,Hu6,Hu7,Hu8,Hu9);

%% Normalizamos 
% Para que los valores para que esten en el rango [0,1]
Hu0 = -sign(Hu0).*log(abs(Hu0));
Hu1 = -sign(Hu1).*log(abs(Hu1));
Hu2 = -sign(Hu2).*log(abs(Hu2));
Hu3 = -sign(Hu3).*log(abs(Hu3));
Hu4 = -sign(Hu4).*log(abs(Hu4));
Hu5 = -sign(Hu5).*log(abs(Hu5));
Hu6 = -sign(Hu6).*log(abs(Hu6));
Hu7 = -sign(Hu7).*log(abs(Hu7));
Hu8 = -sign(Hu8).*log(abs(Hu8));
Hu9 = -sign(Hu9).*log(abs(Hu9));

%% Agrupamos en vectores de caracteristicas
Hu_ord1_ = [Hu0(1,:); Hu1(1,:); Hu2(1,:); Hu3(1,:); Hu4(1,:);...
           Hu5(1,:); Hu6(1,:); Hu7(1,:); Hu8(1,:); Hu9(1,:)];

Hu_ord2_ = [Hu0(2,:); Hu1(2,:); Hu2(2,:); Hu3(2,:); Hu4(2,:);...
           Hu5(2,:); Hu6(2,:); Hu7(2,:); Hu8(2,:); Hu9(2,:)];

Hu_ord3_ = [Hu0(3,:); Hu1(3,:); Hu2(3,:); Hu3(3,:); Hu4(3,:);...
           Hu5(3,:); Hu6(3,:); Hu7(3,:); Hu8(3,:); Hu9(3,:)];

Hu_ord4_ = [Hu0(4,:); Hu1(4,:); Hu2(4,:); Hu3(4,:); Hu4(4,:);...
           Hu5(4,:); Hu6(4,:); Hu7(4,:); Hu8(4,:); Hu9(4,:)];

%% Visualizar Hus
%Visualizamos la separación entre clases que nos ofrecen los momentos
PlotearHus2

%% Prototipos
%Calculamos el prototipo de cada clase.
%z0, z1, ..., z8, z9
Hu_ord1_media = mean(Hu_ord1_,2);
Hu_ord2_media = mean(Hu_ord2_,2);
Hu_ord3_media = mean(Hu_ord3_,2);
Hu_ord4_media = mean(Hu_ord4_,2);

z0 = [Hu_ord1_media(1); Hu_ord2_media(1); Hu_ord3_media(1); Hu_ord4_media(1)];
z1 = [Hu_ord1_media(2); Hu_ord2_media(2); Hu_ord3_media(2); Hu_ord4_media(2)];
z2 = [Hu_ord1_media(3); Hu_ord2_media(3); Hu_ord3_media(3); Hu_ord4_media(3)];
z3 = [Hu_ord1_media(4); Hu_ord2_media(4); Hu_ord3_media(4); Hu_ord4_media(4)];
z4 = [Hu_ord1_media(5); Hu_ord2_media(5); Hu_ord3_media(5); Hu_ord4_media(5)];
z5 = [Hu_ord1_media(6); Hu_ord2_media(6); Hu_ord3_media(6); Hu_ord4_media(6)];
z6 = [Hu_ord1_media(7); Hu_ord2_media(7); Hu_ord3_media(7); Hu_ord4_media(7)];
z7 = [Hu_ord1_media(8); Hu_ord2_media(8); Hu_ord3_media(8); Hu_ord4_media(8)];
z8 = [Hu_ord1_media(9); Hu_ord2_media(9); Hu_ord3_media(9); Hu_ord4_media(9)];
z9 = [Hu_ord1_media(10); Hu_ord2_media(10); Hu_ord3_media(10); Hu_ord4_media(10)];

%% Clasificacion
%Para clasificar la imagen, primero obtenemos los momentos de Hu
%de cada dígito que contenga
X = moments2('Imagenes/Matricula_aleatoria1.png');

%Normalizamos
X = -sign(X).*log(abs(X));
%Calculamos las distancias a cada prototipo
dists = [sqrt(sum((X-z0).^2));...
         sqrt(sum((X-z1).^2));...
         sqrt(sum((X-z2).^2));...
         sqrt(sum((X-z3).^2));...
         sqrt(sum((X-z4).^2));...
         sqrt(sum((X-z5).^2));...
         sqrt(sum((X-z6).^2));...
         sqrt(sum((X-z7).^2));...
         sqrt(sum((X-z8).^2));...
         sqrt(sum((X-z9).^2))];
     
 [C,I] = min(dists);
 
 img = imread('Imagenes/Matricula_aleatoria1.png'); 
 figure()
 imshow(img);
 hold on
 for i = 1:length(I)
     text(i*70,0,int2str(I(i)-1),'FontSize',14,'Color','cyan');
 end
 hold off
