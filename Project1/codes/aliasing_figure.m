function out = aliasing_figure()
    n1 = 0:0.001:2*pi ;
    syms x 
    sympref('HeavisideAtOrigin',1);
    y1(x) = (-2/(3*pi)*x + 1)*heaviside(-x + 3*pi/2);
    y2(x) = (2/(3*pi)*x - 1/3) *heaviside(x - pi/2);
    plot(n1,y1(n1)+y2(n1))
    title(" |X| ");
    xlabel("F(rad/s)");
    grid on;
end
