function [coef1, coef2] = partA(x, y, d)
    [m,~] = size(x);
    A = ones(m,d+1);
    for j=d:-1:1
        A(:,j) = A(:,j+1).*x;%d+1in hepsi 1 (d den baslayarak)x leri Aya uygulama islemi.
    end
    B = [A A];%b matrisi
    coef = (B'*B) \ (B'*y);
    
    coef1 = coef(1:d+1);%coefleri ayirma islemi.
    coef2 = coef(d+2:end);
    
    o1 = A * coef1;
    o2 = A * coef2;

    % Plot
    % NO Need to Change This Part
    figure;
    scatter(x, y, 'filled', 'b');
    hold on;
    plot(x, o1, 'Linewidth', 1.5, 'Color', 'r');
    plot(x, o2, 'Linewidth', 1.5, 'Color', 'g');
    title('Part A');
end