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
Hu0_ = (Hu0 - min(Hu0)) ./ (max(Hu0) - min(Hu0));
Hu1_ = (Hu1 - min(Hu1)) ./ (max(Hu1) - min(Hu1));
Hu2_ = (Hu2 - min(Hu2)) ./ (max(Hu2) - min(Hu2));
Hu3_ = (Hu3 - min(Hu3)) ./ (max(Hu3) - min(Hu3));
Hu4_ = (Hu4 - min(Hu4)) ./ (max(Hu4) - min(Hu4));
Hu5_ = (Hu5 - min(Hu5)) ./ (max(Hu5) - min(Hu5));
Hu6_ = (Hu6 - min(Hu6)) ./ (max(Hu6) - min(Hu6));
Hu7_ = (Hu7 - min(Hu7)) ./ (max(Hu7) - min(Hu7));
Hu8_ = (Hu8 - min(Hu8)) ./ (max(Hu8) - min(Hu8));
Hu9_ = (Hu9 - min(Hu9)) ./ (max(Hu9) - min(Hu9));


%% Agrupamos en vectores de caracteristicas
Hu_ord1 = [Hu0_(1,:); Hu1_(1,:); Hu2_(1,:); Hu3_(1,:); Hu4_(1,:);...
           Hu5_(1,:); Hu6_(1,:); Hu7_(1,:); Hu8_(1,:); Hu9_(1,:)];

Hu_ord2 = [Hu0_(2,:); Hu1_(2,:); Hu2_(2,:); Hu3_(2,:); Hu4_(2,:);...
           Hu5_(2,:); Hu6_(2,:); Hu7_(2,:); Hu8_(2,:); Hu9_(2,:)];

Hu_ord3 = [Hu0_(3,:); Hu1_(3,:); Hu2_(3,:); Hu3_(3,:); Hu4_(3,:);...
           Hu5_(3,:); Hu6_(3,:); Hu7_(3,:); Hu8_(3,:); Hu9_(3,:)];

Hu_ord4 = [Hu0(4,:); Hu1(4,:); Hu2(4,:); Hu3(4,:); Hu4(4,:);...
           Hu5(4,:); Hu6(4,:); Hu7(4,:); Hu8(4,:); Hu9(4,:)];

%% Visualizar Hus
%Visualizamos la separación entre clases que nos ofrecen los momentos
%PlotearHus2

%% Prototipos
%Calculamos el prototipo de cada clase.
%z0, z1, ..., z8, z9
Hu_ord1_media = mean(Hu_ord1,2);
Hu_ord2_media = mean(Hu_ord2,2);
Hu_ord3_media = mean(Hu_ord3,2);
Hu_ord4_media = mean(Hu_ord4,2);

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
     text(i*100,0,int2str(I(i)-1),'FontSize',14,'Color','cyan');
 end
 hold off