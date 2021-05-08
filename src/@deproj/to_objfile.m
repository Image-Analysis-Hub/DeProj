function to_objfile( obj, file_name, simplified )
%TO_FILE Exports results to an OBJ file.
% See  https://en.wikipedia.org/wiki/Wavefront_.obj_file


    if nargin < 3
        simplified = false;
    end
    
    fid = fopen( file_name, 'w' );
    
    % Header
    fprintf( fid, '# Exported from DeProj on %s\n', ...
        datestr(now) );
    
    
    if simplified
        
        % EXPORT ONLY JUNCTION GRAPHS.
        fprintf( fid, '# Simplified tissue mesh.\n' );
        
        [ V, F ] = obj.graph_to_VF();
        n_vertices = size( V, 1 );
        n_faces = size( F, 1 );
        fprintf( fid, '# %d vertices\n', n_vertices );
        fprintf( fid, '# %d faces\n', n_faces );
        fprintf( fid, '\n' );
        
        % Vertices.
        for i = 1 : n_vertices
            fprintf( fid, 'v %f %f %f\n', V( i, 1 ), V( i, 2 ), V( i, 3 ) );
        end
        fprintf( fid, '\n' );
        
        % Faces.
        max_n_vertices = size( F, 2 );
        for i = 1 : n_faces
            fprintf( fid, 'f' );
            for j = 1 : max_n_vertices
                id = F( i, j );
                if isnan( id )
                    break;
                end
                fprintf( fid, ' %d', id );
            end
            fprintf( fid, '\n' );
        end
        fprintf( fid, '\n' );
        
    else
        
        % EXPORT FULL CELL CONTOURS.
        fprintf( fid, '# tissue mesh with cell contours.\n' );
        
        epicells = obj.epicells;
        boundaries = { epicells.boundary };
        
        n_vertices = sum( cellfun( @(c) size(c,1), boundaries) );
        n_faces = numel( boundaries );
        fprintf( fid, '# %d vertices\n', n_vertices );
        fprintf( fid, '# %d faces\n', n_faces );
        fprintf( fid, '\n' );
        
        % Vertices.
        for i = 1 : n_faces
            
            V = boundaries{ i };
            n_points = size( V, 1 );
            for j = 1 : n_points
                fprintf( fid, 'v %f %f %f\n', V( j, 1 ), V( j, 2 ), V( j, 3 ) );
            end
            
        end
        fprintf( fid, '\n' );
        
        % Faces.
        id = 0;
        for i = 1 : n_faces
            fprintf( fid, 'f' );
            V = boundaries{ i };
            n_points = size( V, 1 );
            for j = 1 : n_points
                id = id + 1;
                fprintf( fid, ' %d', id );
            end            
            fprintf( fid, '\n' );
            
        end
        fprintf( fid, '\n' );
        
    end
    
    fclose( fid );
end
