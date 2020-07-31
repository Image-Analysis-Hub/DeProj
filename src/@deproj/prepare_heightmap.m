function H = prepare_heightmap( H, voxel_depth, smooth_scale, invert_z, inpaint_zeros, prune_zeros )
%PREPARE_HEIGHTMAP Prepare the height-map image according to user settings.

    if nargin < 6
        prune_zeros = true;
    end
    if nargin < 5
        inpaint_zeros = true;
    end
    if nargin < 4
        invert_z = false;
    end
    if nargin < 3
        smooth_scale = -1.;
    end
    if nargin < 2
        voxel_depth = 1.;
    end

    %% Process height-map.

    if inpaint_zeros
        mask = H == 0;
        H = regionfill( H, mask );
    end

    if prune_zeros
        H( H == 0 ) = NaN;
    end

    if smooth_scale > 0
        H = imgaussfilt( H, smooth_scale );
    end

    if invert_z
        H = max(H(:)) - H;
    end
    
    H = H * voxel_depth;

end

