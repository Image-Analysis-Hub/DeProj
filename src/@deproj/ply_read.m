function [ V, F, comments ] = ply_read( file_path )
%% PLY_READ Read a PLY file.
% WARNING: This is a simplistic reader that can only handle one kind of
% data formatting. The file must be a binary encoded following the
% binary_little_endian format, there must be 3 floats per vertex, and 3
% integer per face, nothing else. Any variation will result in a crash at
% best.

% ply
% format binary_little_endian 
% comment VCGLIB generated -> I did it with MeshLab.
% element vertex 2607
% property float x
% property float y
% property float z
% element face 5000
% property list uchar int vertex_indices
% end_header

    INT_SIZE        = 8;
    UCHAR_SIZE      = 1;

    fid = fopen( file_path, 'r' );

    % Check 1st line.
    first_line = fgetl( fid );
    if ~strcmpi( first_line, 'ply')
        error( 'ply_read:NotPLYFile', '%s is not a PLY file.', file_path)
    end

    current_line = first_line;
    comments = {};
    while ~strcmpi( current_line, 'end_header')

        current_line = fgetl( fid );

        if startsWith( current_line, 'comment ', 'IgnoreCase', true )
            comments = [ comments
                current_line( numel( 'comment ' ) : end )
                ]; %#ok<AGROW>
        end

        if startsWith( current_line, 'element vertex ', 'IgnoreCase', true )
            n_vertices = str2double( current_line( numel( 'element vertex ' ) : end ) );
        end

        if startsWith( current_line, 'element face ', 'IgnoreCase', true )
            n_faces = str2double( current_line( numel( 'element face ' ) : end ) );
        end

    end

    vertex_record_length = 3;
    V = fread( fid, vertex_record_length * n_vertices, 'single' );
    V = reshape( V, [ vertex_record_length n_vertices ] )';

    face_record_length = 3;
    % Read the whole block as bytes, that we will decode later.
    block = fread( fid, ( 3 * INT_SIZE + UCHAR_SIZE ) * n_faces, '*uint8' );

    F = zeros( n_faces, face_record_length, 'int32' );
    index = 1;
    for i = 1 : n_faces

        index = index + 1;
        [ val, index ] = read_int( block, index );
        F( i , 1 ) = 1 + val;
        [ val, index ] = read_int( block, index );
        F( i , 2 ) = 1 + val;
        [ val, index ] = read_int( block, index );
        F( i , 3 ) = 1 + val;
    end


    fclose( fid );
    
    
    function [ val, index ] = read_int( block, index )
        val = typecast( block( index : index + 3 ), 'int32' );
        index = index + 4;
    end

end