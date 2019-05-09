function ChStern = convEGtoCStern(EG, CvStern, g)
    ChStern = 1 ./ ( 1 / CvStern - EG * g );
end