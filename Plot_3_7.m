function Plot_3_7(plotInstance,FBv,FBh,lv,l,h)
    
plot(plotInstance,FBv, FBh)
sFBh = size(FBh);
sFBv = size(FBv);

maxFBh = (lv/l)*(lv/l)/(4*(h/l));
maxFBhFBv = (lv/l)*(2-(lv/l))/(4*(h/l));
maxFBv = -(1-(lv/l))*(1-(lv/l))/(4 * (h/l));
maxFBvFBh = -(1-(lv/l)*(lv/l))/(4*(h/l));

x = FBh(end)*ones(sFBh(2), 1);
y = FBv(1)*ones(sFBv(2), 1);

hold on;
            
plot(plotInstance,[0 maxFBhFBv maxFBhFBv],[maxFBh maxFBh 0], 'color', [0.0 0.0 0.0]);
plot(plotInstance,[0 maxFBv maxFBv],[maxFBvFBh maxFBvFBh 0], 'color', [0.0 0.0 0.0]);
plot(plotInstance,FBv, x, 'color', [0.0 0.0 0.0])
plot(plotInstance,y, FBh, 'color', [0.0 0.0 0.0])
plot(plotInstance,maxFBhFBv, maxFBh, '*', 'color', [1.0 0.0 0.0])
plot(plotInstance,maxFBv, maxFBvFBh, '*', 'color', [1.0 0.0 0.0])
hold off;
xlabel(plotInstance,'FBv')
ylabel(plotInstance,'FBh')
grid on;

end

