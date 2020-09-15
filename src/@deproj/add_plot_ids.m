function hts = add_plot_ids( obj, ax )
%ADD_PLOT_IDS Add the epicell ids to the specified plot axes.

    texts = num2cell( vertcat( obj.epicells.id ) );
    hts = obj.plot_text( texts, ax );
end

