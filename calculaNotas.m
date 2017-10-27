function calculaNotas(imagemOriginal)

% Lê a imagem
imagemOriginal = imread(imagemOriginal);

% Recorta a imagem, mantendo apenas a área central
imagemOriginal = imcrop(imagemOriginal,[80 25 520 355]);

figure(1), imshow(imagemOriginal);

% Converte de RGB para tons de cinza
imagem = rgb2gray(imagemOriginal);

% Pega o tamanho (altura x largura)
[H,W] = size(imagem);

% Transforma o resultado em double
% para trabalhar com a imagem binária
resultado = double(imagem(:,:,1));

% Algoritmo de Binarização
for i=1:H
    for j=1:W
        if (imagem(i,j) >= 80)
            resultado(i,j) = 1;
        else
            resultado(i,j) = 0;
        end
    end
end

figure(2), imshow(resultado);

% Algoritmo para remover os pontos pretos das áreas brancas
for i=2:H-1
    for j=2:W-1
        mediaTemp = (resultado(i-1,j-1) + resultado(i-1,j) + resultado(i-1,j+1) + ...
                     resultado(i,j-1) + resultado(i,j) + resultado(i,j+1) + ...
                     resultado(i+1,j-1) + resultado(i+1,j) + resultado(i+1,j+1));
        
        if(mediaTemp >= 5)
            resultado(i,j) = 1;
        end
    end
end

figure(3), imshow(resultado);

% Preenche possíveis buracos na imagem binarizada
imagemFinal = imfill(resultado, 'holes');

figure(4), imshow(imagemFinal);

% Cria labels nas imagens em diferentes tons de cinza
labeledImage = bwlabel(imagemFinal, 8);

figure(5), imshow(labeledImage);

for i=1:H
    for j=1:W
        if(labeledImage(i,j) == 4)
            labeledImage(i,j) = 1;
        end
        if(labeledImage(i,j) > 9)
            labeledImage(i,j) = 0;
        end
    end
end

% Vetor para guardar as 3 possíveis notas
area = [0,0,0];

for i=1:H
    for j=1:W
        if((labeledImage(i,j) ~= 0) && (labeledImage(i,j) ~= 3))
           if(mod(labeledImage(i,j),3) == 0)
                labeledImage(i,j) = (1 + mod(labeledImage(i,j),3));
           else
                labeledImage(i,j) = mod(labeledImage(i,j),3);
           end
        end
    end
end

% Pega o tamanho (altura x largura)
[H, W] = size(labeledImage);

% Algoritmo para calcular a área de cada nota presente na imagem
for i=1:H
    for j=1:W
        % fprintf('%i\n', labeledImage(i,j));
        if(labeledImage(i,j) == 1)
            area(1) = area(1) + 1;
        end
        if(labeledImage(i,j) == 2)
            area(2) = area(2) + 1;
        end
        if(labeledImage(i,j) == 3)
            area(3) = area(3) + 1;
        end
    end
end

% Variáveis contadoras de notas da imagem
valor = 0;
nota5 = 0;
nota10 = 0;
nota20 = 0;
nota50 = 0;
nota100 = 0;

% Tendo como base a área de cada objeto detectado
% na imagem, conforme o tamanho, é detectada uma nota
for i=1:length(area)
    fprintf('Area %i: %.2f\n', i, area(i));
    if((area(i) >= 37000) && (area(i) <= 38499))
        nota5 = nota5 + 1;
        valor = valor + 5;
    end
    if((area(i) >= 38500) && (area(i) <= 40600))
        nota10 = nota10 + 1;
        valor = valor + 10;
    end
    if((area(i) >= 40601) && (area(i) <= 43999))
        nota20 = nota20 + 1;
        valor = valor + 20;
    end
    if((area(i) >= 44000) && (area(i) <= 48500))
        nota50 = nota50 + 1;
        valor = valor + 50;
    end
    if((area(i) >= 48501) && (area(i) <= 52000))
        nota100 = nota100 + 1;
        valor = valor + 100;
    end
end

fprintf('Notas de 5: %i\n', nota5);
fprintf('Notas de 10: %i\n', nota10);
fprintf('Notas de 20: %i\n', nota20);
fprintf('Notas de 50: %i\n', nota50);
fprintf('Notas de 100: %i\n', nota100);
fprintf('Valor (R$): %.2f\n', valor);

end