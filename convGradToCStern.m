function [CvStern, ChStern] = convGradToCStern(EG, SG, g, ChStern) 
    %variable inputnumber if ChStern not being parsed
    if(nargin == 3)
        ChStern = 1./(g*SG);
    else
        SG = 1./(g*ChStern);
    end

    CvStern = 1./(g*(EG+SG));
end



