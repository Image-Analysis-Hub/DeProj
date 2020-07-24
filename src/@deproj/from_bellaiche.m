function obj = from_bellaiche( ...
    cells, ...
    frame, ...
    sides, ...
    vertices, ...
    mesh_file_path, ...
    units )
%FROM_BELLAICHE Returns a deproj object built from the results of the tool
%from Yohannes Bellaiche lab.

    %% Get information about source image.

    width = frame.imageSize( 1 );
    pixel_size = frame.scale1D;
    
    %% Read the mesh file.
    
    fprintf('Loading and processing the tissue mesh file.\n' )
    tic
    
    V = deproj.ply_read( mesh_file_path );
    si = scatteredInterpolant( V(:,1), V(:,2), V(:,3), 'linear', 'nearest' );
    
    fprintf('Loaded %d vertices in %.1f seconds.\n', size(V, 1), toc )
    
    
    %% Build the junction graph.
    
    tic
    fprintf('Building the junction graph.\n' )
    
    edge_table = table();
    
    % Prune duplicate edges.
    edge_table.EndNodes = unique( sides.vertices, 'rows' );
    
    node_table = table();
    jxy = vertices.XYs;

    jz = si( jxy );
    node_table.Centroid = [ jxy jz ];
    node_table.ID = vertices.numbers;
    
    junction_graph = graph( edge_table, node_table, 'omitselfloops' );
    
    fprintf('Built the junction graph with %d nodes and %d edges in %.1f seconds.\n', ...
        junction_graph.numnodes, junction_graph.numedges, toc )
    
    %% Convert YB structure to epicells.
    
    n_cells = numel( cells.contour_indices );

    fprintf('Computing morphological descriptors of %d objects.\n', n_cells-1 )
    tic
    
    % We don't go for the first one, which contains the contour of the tissue.
    % Get boundary.
    for i = n_cells : -1 : 2
        
        % Get the boundary.
        % It is about converting linear indices to XY coordinates. We do
        % this by integer division since we know the image width.
        ids = int32( cells.contour_indices{ i } );
        x = idivide( ids, width);
        y = rem( ids, width);
        P = double( [ x y ] );
        P = deproj.find_countour( P );
        P = P * pixel_size;
        
        % Get Z from the mesh.
        z = si( P );
        boundary = [ P z ];
        
        % Get the junction ids.
        junction_ids = cells.vertices{ i };
        
        id = cells.numbers( i );
        epicells( i-1 ) = epicell( boundary, junction_ids, id );
        
        
    end
    
    fprintf('Done in %.1f seconds.\n', toc )
    
    obj = deproj( epicells, junction_graph, units );
    
    
end

