function Plot_4_8(plot_instance,gravity, lv, lh, lEG, lSG, is, m, theta)
    deltaControlled = 0;
    g = gravity;

    EG = [max(-lEG, -lSG*0.9) 0 max(lEG, -lSG*0.9)]; 
    SG = lSG;  % SG must be greater than min(EG)!
    ChStern = 1./(g*SG); 
    CvStern = 1./(g*(EG+(1./(g*ChStern))));
    vmax = int32(sqrt((lv+lh)/max(EG)) + 5); % charakteristische Geschwindigkeit
    vmax = vmax + (5 - mod(vmax,5)); % Runden auf 5er Schritte

    deltaH = 1;
    deltaH_array = deltaH * ones(1,int32(vmax));
    v = 1:vmax;
    max_limit_y = 0;

    colors = ['r', 'g', 'b'];
    hold(plot_instance,'off');

    for k = 1:size(CvStern,2)
        [~, ~, dpsi_val] = runQuerdynamik(10, 0.001, deltaH_array, 1, v, CvStern(k), ChStern, deltaControlled, lv, lh, is, m, theta, g);
        yVals = dpsi_val/(deltaH/is);
        max_limit_y = max(max(yVals), max_limit_y);
        if k > 1
            plot(plot_instance, v, yVals, 'LineWidth', 2, 'Color', colors(k));
        else
            diffs = yVals(2:end) - yVals(1:end-1);
            falling = int32(diffs < 0);
            k_max = min(falling .* int32(1:(size(yVals,2)-1)) + (1-falling) .* 10000);
            plot(plot_instance, v(1:k_max), yVals(1:k_max), 'LineWidth', 2, 'Color', colors(k));
        end
        hold(plot_instance,'on');
    end
    ylim(plot_instance, [0 max_limit_y]);
    grid(plot_instance, 'on');
    legend(plot_instance, strcat('EG=',num2str(EG(1),2)),  strcat('EG=',num2str(EG(2),2)), strcat('EG=',num2str(EG(3),2)), 'Location','northwest');
    xlabel(plot_instance,'Geschwindigkeit')
    ylabel(plot_instance,'Gierverstaerkung')
end
