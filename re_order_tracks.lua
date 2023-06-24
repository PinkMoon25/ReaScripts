local trackOrder = {'drums', 'drums-2', 'guitar', 'guitar-1', 'guitar-2', 'sarod', 'vocal'} -- Replace with your desired track names and order

for targetIndex, trackNameToMove in ipairs(trackOrder) do
    -- Find the track index of the track to move
    local trackToMoveIndex = nil
    for i = 0, reaper.CountTracks(0) - 1 do
        local track = reaper.GetTrack(0, i)
        local _, trackName = reaper.GetTrackName(track, "")

        local isChild = reaper.GetParentTrack(track) ~= nil

        if isChild then
            break
        end

        if trackName == trackNameToMove then
            trackToMoveIndex = i
            break
        end
    end

    -- Check if the track to move was found
    if trackToMoveIndex ~= nil then
        -- Select the track to move
        local trackToMove = reaper.GetTrack(0, trackToMoveIndex)
        reaper.SetTrackSelected(trackToMove, true)

        -- Move the selected track to the target index
        reaper.ReorderSelectedTracks(targetIndex, 0)
        reaper.SetTrackSelected(trackToMove, false)
        -- Update the TCP layout
        reaper.TrackList_AdjustWindows(false)
    end
end
