function [coef1, coef2] = partC(x, y, d1,d2,epoch)
    [m,~] = size(x);
    A = ones(m,d1+1);
    B = ones(m,d2+1);
    for j=d1:-1:1
        A(:,j) = A(:,j+1).*x;
    end
    for j=d2:-1:1
        B(:,j) = B(:,j+1).*x;
    end
    
    MSE_best = 1000*1000*1000;
    coef1 = 0;
    coef2 = 0;
    for k=1:epoch
        C = [A B];
        for i=1:m
            if rand < 0.5
                C(i,1:d1+1) = 0;
            else
                C(i,d1+2:end) = 0;
            end
        end
        coef = (C'*C) \ (C'*y);

        o1 = A * coef(1:d1+1);
        o2 = B * coef(d1+2:end);
        e1 = abs(y - o1);
        e2 = abs(y - o2);
        e = min(e1, e2);
        MSE = e'*e / m;
        if MSE < MSE_best
            MSE_best = MSE;
            coef1 = coef(1:d1+1);
            coef2 = coef(d1+2:end);
        end
    end

    o1 = A * coef1;
    o2 = B * coef2;
    
    % Plot
    % NO Need to Change This Part
    figure;
    scatter(x, y, 'filled', 'b');
    hold on;
    plot(x, o1, 'Linewidth', 1.5, 'Color', 'r');
    plot(x, o2, 'Linewidth', 1.5, 'Color', 'g');
    title('Part C');
end