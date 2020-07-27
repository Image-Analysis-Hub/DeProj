function hts = plot_text( obj, texts, ax )
%PLOT_TEXT Plot text at cell centers.


    C = double( vertcat( obj.epicells.center ) );
    X = C( :, 1 );
    Y = C( :, 2 );
    Z = C( :, 3 ) + 0.5;
    
    hts = text( ax, X, Y, Z, texts, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'Clipping', 'on', ...
        'Interpreter', 'none', ...
        'FontSize', 9 );
end

