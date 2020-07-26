function [ V, F ] = to_vertices_and_faces( obj )
%TO_FACES Returns the faces and vertices of a deproj collection.
% The vertices are made of the junction centroid coordinates.
% Each face is one epicell, enclosed by the junctions around it.

    % Collect vertices.
    g = obj.junction_graph;
    V = g.Nodes.Centroid;

    % Collected junction ids.
    ids = { obj.epicells.junction_ids }';
    n_vertices = cellfun(@numel, ids );
    max_n_vertices = max( n_vertices );
    n_obj = numel( obj.epicells );

    % Write into the face matrix.
    F = NaN( n_obj, max_n_vertices );
    for i = 1 : n_obj
        
        jids = ids{ i };
        P = V( jids, : );
        
        % Sort the points so that we don't have intersecting polygons.
        [ ~, I ] = deproj.sort_polygon( P );
        F( i, 1 : n_vertices(i) ) = jids( I );
    end

end

