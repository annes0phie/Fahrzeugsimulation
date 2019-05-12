function runLaengsdynamik(plotV,plotS,plotA,plotFBvh)
    simout = sim('Laengsdynamik', 'Solver', 'FixedStepDiscrete', 'FixedStep', '0.001', 'Stoptime', '10');
    v = simout.get('v');
    assignin('base','v',v);
    t = simout.get('t');
    assignin('base','t',t);
    s = simout.get('s');
    assignin('base','s',s);
    a = simout.get('a');
    assignin('base','a',a);

    FBv = evalin('base', 'FBv');
    FBh = evalin('base', 'FBh');
    t = evalin('base', 't');
    v = evalin('base', 'v');
    s = evalin('base', 's');
    a = evalin('base', 'a');
    l = evalin('base', 'l');
    lv = evalin('base', 'lv');
    h = evalin('base', 'h');


    Plot_3_7(plotFBvh,FBv,FBh,lv,l,h);

 
    plot(plotV,t, v);
    xlabel(plotV,'Zeit')
    ylabel(plotV,'Geschwindigkeit')
    grid(plotV ,'on');

    
    plot(plotS,t, s);
    xlabel(plotS,'Zeit')
    ylabel(plotS,'Strecke')
    grid(plotS,'on');

  
    plot(plotA,t, a);
    xlabel(plotA,'Zeit')
    ylabel(plotA,'Beschleunigung')
    grid(plotA,'on');
end

