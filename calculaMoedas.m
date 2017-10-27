function calculaMoedas(imagem)

    imagem = imread(imagem);
    imagem = imcrop(imagem,[150 25 420 355]);
    figure(1), imshow(imagem);
    imagem = rgb2gray(imagem);
    figure(2), imshow(imagem);

    [centro, raio] = imfindcircles(imagem,[20 50],'ObjectPolarity','dark','Sensitivity',0.9);
    numMoedas = length(raio);
    centro1 = centro(1:numMoedas,:);
    raio1 = raio(1:numMoedas);
    figure(3), imshow(imagem), hold on
    viscircles(centro1, raio1,'EdgeColor','b');
    
    valor = 0;
    moeda5 = 0;
    moeda10 = 0;
    moeda25 = 0;
    moeda50 = 0;
    moeda100 = 0;
    
    for i=1:numMoedas
       fprintf('Raio %i: %.2f\n', i, raio(i));
       if((raio(i) >= 23) && (raio(i) <= 23.89)) 
           valor = valor + 0.05;
           moeda5 = moeda5 + 1;
           % fprintf('Raios 5: %.2f\n', raio(i));
       end
       if((raio(i) >= 20) && (raio(i) <= 22.99)) 
           valor = valor + 0.10;
           moeda10 = moeda10 + 1;
           % fprintf('Raios 10: %.2f\n', raio(i));
       end
       if((raio(i) >= 26.02) && (raio(i) <= 27.02)) 
           valor = valor + 0.25;
           moeda25 = moeda25 + 1;
           % fprintf('Raios 25: %.2f\n', raio(i));
       end
       if((raio(i) >= 23.90) && (raio(i) <= 26.01)) 
           valor = valor + 0.50;
           moeda50 = moeda50 + 1;
           % fprintf('Raios 50: %.2f\n', raio(i));
       end
       if((raio(i) >= 27.03) && (raio(i) <= 30)) 
           valor = valor + 1;
           moeda100 = moeda100 + 1;
           % fprintf('Raios 100: %.2f\n', raio(i));
       end
    end
    
   fprintf('Moedas de 5 centavos: %i\n', moeda5);
   fprintf('Moedas de 10 centavos: %i\n', moeda10);
   fprintf('Moedas de 25 centavos: %i\n', moeda25);
   fprintf('Moedas de 50 centavos: %i\n', moeda50);
   fprintf('Moedas de 1 real: %i\n', moeda100);
   fprintf('Valor total na imagem: R$ %.2f\n', valor);

end