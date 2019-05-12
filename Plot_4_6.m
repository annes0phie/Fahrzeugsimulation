function Plot_4_6(plotInstance, subplot, VorR, gravity, lv, lh, lEG, lSG, is, m, theta)

    if(strcmp(subplot,'Plot_4_6_1'))
        deltaControlled = 0; %konst v
        deltaH = 0:0.02:6;
        v = VorR;
        rSoll = 1;
        g = gravity;
        simStep = 0.001;
        simTime =10;
    end
    if(strcmp(subplot,'Plot_4_6_2'))
        deltaControlled = 1; 
        deltaH = 1;
        v = 2.5:1.0:20.0;
        rSoll = VorR;
        g = gravity;
        simStep = 0.001 - (rSoll/40*0.0009);
        simTime = 10 - (rSoll/40*9);
    end


    EG = [max(-lEG, -lSG*0.9) 0 lEG];
    SG = lSG;  % SG must be greater than min(EG)!

    ChStern = 1./(g*SG);
    CvStern = convGradToCStern(EG, 0, g, ChStern);

    colors = [[0 0 0.5], [0.8 0.4 0], [0.5 0 0]];

    hold(plotInstance,'off');
    for k = 1:size(CvStern,2)
        [ay_val, delta_val] = runQuerdynamik(simTime, simStep, deltaH, rSoll, v, CvStern(k), ChStern, deltaControlled, lv, lh, is, m, theta, g);
        plot(plotInstance, ay_val, delta_val, 'LineWidth', 2, 'Color', colors((k-1)*3+1:k*3));
        hold(plotInstance,'on');
    end
    grid(plotInstance,'on');
    legend(plotInstance, strcat('EG=',num2str(EG(1),2)),  strcat('EG=',num2str(EG(2),2)), strcat('EG=',num2str(EG(3),2)), 'Location','northwest'); %'EG='+num2str(EG(2)), 'EG='+num2str(EG(3))
    xlabel(plotInstance,'Querbeschleunigung')
    ylabel(plotInstance,'Radwinkel')
end