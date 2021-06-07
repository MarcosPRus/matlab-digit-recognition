function [Hu, centroids] = moments2(file)
    img = imread(file);
    [M,N,C] = size(img);
    img_bin = zeros(M,N);
    
    %Depuramos la imagen por colores para dejar solo numeros y bordes
    %negros
    for i = 1:M-1
        for j = 1:N-1
            if(img(i,j,1)>=25 && img(i,j,1)<=50 &&...
            img(i,j,2)>=30 && img(i,j,2)<=40 &&...
            img(i,j,3)>=30 && img(i,j,3)<=55)
                img_bin(i,j) = 1;
            else
                img_bin(i,j) = 0;
            end
        end
    end
    
    %Abrimos y cerramos para eliminar el ruido
    se = strel('disk',1);
    img_bin = imopen(img_bin,se);
    se = strel('disk',2);
    img_bin = imclose(img_bin,se);
    
    %imshow(img_bin)
    
    %Imagen binaria etiquetada
    img_etiq = bwlabel(img_bin);
    
    centroids = regionprops(img_etiq, 'Centroid');
    
    %Numero de regiones en la imagen
    n = max(max(img_etiq));
    
    phi1 = [];
    phi2 = [];
    phi3 = [];
    phi4 = [];
    phi5 = [];
    phi6 = [];
    phi7 = [];
    
    for i = 1:n
        img_aux = (img_etiq==i);
        
        %Momentos de orden 0
        m00 = sum(sum(img_aux));
        
        %Momentos de orden 1 (Para obtencion de centro de masas)
        m01 = 0; m10 = 0;
        for x = 1:N
            for y = 1:M
                m10 = m10 + x*double(img_aux(y,x));
                m01 = m01 + y*double(img_aux(y,x));
            end
        end
        xCM = m10/m00;
        yCM = m01/m00;
        
        %Momentos centrales (Para los momentos centrales normalizados)
        mu00 = m00;
        mu11 = 0;
        mu20 = 0; mu02 = 0;
        mu30 = 0; mu03 = 0;
        mu12 = 0; mu21 = 0;
        for x = 1:N
            for y = 1:M
                mu11 = mu11 + (x-xCM)*(y-yCM)*double(img_aux(y,x));
                mu20 = mu20 + ((x-xCM)^2)*double(img_aux(y,x));
                mu02 = mu02 + ((y-yCM)^2)*double(img_aux(y,x));
                mu30 = mu30 + ((x-xCM)^3)*double(img_aux(y,x));
                mu03 = mu03 + ((y-yCM)^3)*double(img_aux(y,x));
                mu12 = mu12 + (x-xCM)*((y-yCM)^2)*double(img_aux(y,x));
                mu21 = mu21 + ((x-xCM)^2)*(y-yCM)*double(img_aux(y,x));
            end
        end
        
        %Momentos centrales normalizados (Para los momentos de Hu)
        eta11 = mu11/(mu00^2);
        eta20 = mu20/(mu00^2);
        eta02 = mu02/(mu00^2);
        eta30 = mu30/(mu00^(2.5));
        eta03 = mu03/(mu00^(2.5));
        eta12 = mu12/(mu00^(2.5));
        eta21 = mu21/(mu00^(2.5));
        
        %Momentos de Hu
        phi1 = [phi1 (eta20+eta02)];
        phi2 = [phi2 ((eta20-eta02)^2 + 4*eta11^2)];
        phi3 = [phi3 ((eta30-3*eta12)^2 + (3*eta21-eta03)^2)];
        phi4 = [phi4 ((eta30+eta12)^2 + (eta21+eta03)^2)];
        phi5 = [phi5 ((eta30-3*eta12)*(eta30+eta12)*((eta30+eta12)^2-3*(eta21+eta03)^2)+(3*eta21-eta03)*(eta21+eta03)*(3*(eta30+eta12)^2-(eta21+eta03)^2))];
        phi6 = [phi6 ((eta20-eta02)*((eta30+eta12)^2-(eta21+eta03)^2)+4*eta11*(eta30+eta12)*(eta21+eta03))];
        phi7 = [phi7 ((3*eta21-eta03)*(eta30+eta12)*((eta30+eta12)^2-3*(eta21+eta03)^2)-(eta30-3*eta12)*(eta21+eta03)*(3*(eta30+eta12)^2-(eta21+eta03)^2))];      
    end
    
    Hu = [phi1; phi2; phi3; phi4];
    %Hu = [phi1; phi2; phi3; phi4; phi5; phi6; phi7];

    %Normalizamos v1
    %Hu = [phi1; phi2*10; phi3*100; phi4*100];

    %Normalizamos v2
    %Hu = (Hu - min(Hu)) ./ (max(Hu) - min(Hu));

    %Normalizamos v3
    Hu = -sign(Hu).*log(abs(Hu));

    %Normalizamos v4
    %Hu = autosc(Hu)
    
end