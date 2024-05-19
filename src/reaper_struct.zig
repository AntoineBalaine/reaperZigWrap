var reaper: struct {
    plugin_register: *fn (name: *const c_char, infostruct: *anyopaque) callconv(.C) c_int,
    plugin_getapi: *fn (name: [*c]const u8) callconv(.C) ?*anyopaque,
/// __mergesort
/// __mergesort is a stable sorting function with an API similar to qsort().
/// HOWEVER, it requires some temporary space, equal to the size of the data being sorted, so you can pass it as the last parameter,
/// or NULL and it will allocate and free space internally.
// TODO fix merge sort
// __mergesort: *fn (*void base, size_t nmemb, size_t size, c_int (*cmpfunc)(const *void,const *void), *void tmpspace) callconv(.C) void;

/// AddCustomizableMenu
/// menuidstr is some unique identifying string
/// menuname is for main menus only (displayed in a menu bar somewhere), NULL otherwise
/// kbdsecname is the name of the KbdSectionInfo registered by this plugin, or NULL for the main actions section
AddCustomizableMenu: *fn (const *c_char menuidstr, const *c_char menuname, const *c_char kbdsecname, bool addtomainmenu) callconv(.C) bool;

/// AddExtensionsMainMenu
/// Add an Extensions main menu, which the extension can populate/modify with plugin_register("hookcustommenu")
AddExtensionsMainMenu: *fn () callconv(.C) bool;

/// AddMediaItemToTrack
/// creates a new media item.
AddMediaItemToTrack: *fn (*MediaTrack tr) callconv(.C) *MediaItem;

/// AddProjectMarker
/// Returns the index of the created marker/region, or -1 on failure. Supply wantidx>=0 if you want a particular index number, but you'll get a different index number a region and wantidx is already in use.
AddProjectMarker: *fn (*ReaProject proj, bool isrgn, double pos, double rgnend, const *c_char name, c_int wantidx) callconv(.C) c_int;

/// AddProjectMarker2
/// Returns the index of the created marker/region, or -1 on failure. Supply wantidx>=0 if you want a particular index number, but you'll get a different index number a region and wantidx is already in use. color should be 0 (default color), or ColorToNative(r,g,b)|0x1000000
AddProjectMarker2: *fn (*ReaProject proj, bool isrgn, double pos, double rgnend, const *c_char name, c_int wantidx, c_int color) callconv(.C) c_int;

/// AddRemoveReaScript
/// Add a ReaScript (return the new command ID, or 0 if failed) or remove a ReaScript (return >0 on success). Use commit==true when adding/removing a single script. When bulk adding/removing n scripts, you can optimize the n-1 first calls with commit==false and commit==true for the last call.
AddRemoveReaScript: *fn (bool add, c_int sectionID, const *c_char scriptfn, bool commit) callconv(.C) c_int;

/// AddTakeToMediaItem
/// creates a new take in an item
AddTakeToMediaItem(*MediaItem item) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// AddTempoTimeSigMarker
/// Deprecated. Use SetTempoTimeSigMarker with ptidx=-1.
AddTempoTimeSigMarker: *fn (*ReaProject proj, double timepos, double bpm, c_int timesig_num, c_int timesig_denom, bool lineartempochange) callconv(.C) bool;

/// adjustZoom
/// forceset=0,doupd=true,centermode=-1 for default
adjustZoom: *fn (double amt, c_int forceset, bool doupd, c_int centermode) callconv(.C) void;

/// AnyTrackSolo
AnyTrackSolo: *fn (*ReaProject proj) callconv(.C) bool;

/// APIExists
/// Returns true if function_name exists in the REAPER API
APIExists: *fn (const *c_char function_name) callconv(.C) bool;

/// APITest
/// Displays a message window if the API was successfully called.
APITest: *fn () callconv(.C) void;

/// ApplyNudge
/// nudgeflag: &1=set to value (otherwise nudge by value), &2=snap
/// nudgewhat: 0=position, 1=left trim, 2=left edge, 3=right edge, 4=contents, 5=duplicate, 6=edit cursor
/// nudgeunit: 0=ms, 1=seconds, 2=grid, 3=256th notes, ..., 15=whole notes, 16=measures.beats (1.15 = 1 measure + 1.5 beats), 17=samples, 18=frames, 19=pixels, 20=item lengths, 21=item selections
/// value: amount to nudge by, or value to set to
/// reverse: in nudge mode, nudges left (otherwise ignored)
/// copies: in nudge duplicate mode, number of copies (otherwise ignored)
ApplyNudge: *fn (*ReaProject project, c_int nudgeflag, c_int nudgewhat, c_int nudgeunits, double value, bool reverse, c_int copies) callconv(.C) bool;

/// ArmCommand
/// arms a command (or disarms if 0 passed) in section sectionname (empty string for main)
ArmCommand: *fn (c_int cmd, const *c_char sectionname) callconv(.C) void;

/// Audio_Init
/// open all audio and MIDI devices, if not open
Audio_Init: *fn () callconv(.C) void;

/// Audio_IsPreBuffer
/// is in pre-buffer? threadsafe
Audio_IsPreBuffer: *fn () callconv(.C) c_int;

/// Audio_IsRunning
/// is audio running at all? threadsafe
Audio_IsRunning: *fn () callconv(.C) c_int;

/// Audio_Quit
/// close all audio and MIDI devices, if open
Audio_Quit: *fn () callconv(.C) void;

/// Audio_RegHardwareHook
/// return >0 on success
Audio_RegHardwareHook: *fn (bool isAdd, *audio_hook_register_t reg) callconv(.C) c_int;

/// AudioAccessorStateChanged
/// Returns true if the underlying samples (track or media item take) have changed, but does not update the audio accessor, so the user can selectively call AudioAccessorValidateState only when needed. See CreateTakeAudioAccessor, CreateTrackAudioAccessor, DestroyAudioAccessor, GetAudioAccessorEndTime, GetAudioAccessorSamples.
AudioAccessorStateChanged: *fn (*AudioAccessor accessor) callconv(.C) bool;

/// AudioAccessorUpdate
/// Force the accessor to reload its state from the underlying track or media item take. See CreateTakeAudioAccessor, CreateTrackAudioAccessor, DestroyAudioAccessor, AudioAccessorStateChanged, GetAudioAccessorStartTime, GetAudioAccessorEndTime, GetAudioAccessorSamples.
AudioAccessorUpdate: *fn (*AudioAccessor accessor) callconv(.C) void;

/// AudioAccessorValidateState
/// Validates the current state of the audio accessor -- must ONLY call this from the main thread. Returns true if the state changed.
AudioAccessorValidateState: *fn (*AudioAccessor accessor) callconv(.C) bool;

/// BypassFxAllTracks
/// -1 = bypass all if not all bypassed,otherwise unbypass all
BypassFxAllTracks: *fn (c_int bypass) callconv(.C) void;

/// CalcMediaSrcLoudness
/// Calculates loudness statistics of media via dry run render. Statistics will be displayed to the user; call GetSetProjectInfo_String("RENDER_STATS") to retrieve via API. Returns 1 if loudness was calculated successfully, -1 if user canceled the dry run render.
CalcMediaSrcLoudness: *fn (*PCM_source mediasource) callconv(.C) c_int;

/// CalculateNormalization
/// Calculate normalize adjustment for source media. normalizeTo: 0=LUFS-I, 1=RMS-I, 2=peak, 3=true peak, 4=LUFS-M max, 5=LUFS-S max. normalizeTarget: dBFS or LUFS value. normalizeStart, normalizeEnd: time bounds within source media for normalization calculation. If normalizationStart=0 and normalizationEnd=0, the full duration of the media will be used for the calculation.
CalculateNormalization: *fn (*PCM_source source, c_int normalizeTo, double normalizeTarget, double normalizeStart, double normalizeEnd) callconv(.C) double;

/// CalculatePeaks
CalculatePeaks: *fn (*PCM_source_transfer_t srcBlock, *PCM_source_peaktransfer_t pksBlock) callconv(.C) c_int;

/// CalculatePeaksFloatSrcPtr
/// NOTE: source samples field is a pointer to floats instead
CalculatePeaksFloatSrcPtr: *fn (*PCM_source_transfer_t srcBlock, *PCM_source_peaktransfer_t pksBlock) callconv(.C) c_int;

/// ClearAllRecArmed
ClearAllRecArmed: *fn () callconv(.C) void;

/// ClearConsole
/// Clear the ReaScript console. See ShowConsoleMsg
ClearConsole: *fn () callconv(.C) void;

/// ClearPeakCache
/// resets the global peak caches
ClearPeakCache: *fn () callconv(.C) void;

/// ColorFromNative
/// Extract RGB values from an OS dependent color. See ColorToNative.
ColorFromNative: *fn (c_int col, *c_int rOut, *c_int gOut, *c_int bOut) callconv(.C) void;

/// ColorToNative
/// Make an OS dependent color from RGB values (e.g. RGB() macro on Windows). r,g and b are in [0..255]. See ColorFromNative.
ColorToNative: *fn (c_int r, c_int g, c_int b) callconv(.C) c_int;

/// CountActionShortcuts
/// Returns the number of shortcuts that exist for the given command ID.
/// see GetActionShortcutDesc, DeleteActionShortcut, DoActionShortcutDialog.
CountActionShortcuts: *fn (*KbdSectionInfo section, c_int cmdID) callconv(.C) c_int;

/// CountAutomationItems
/// Returns the number of automation items on this envelope. See GetSetAutomationItemInfo
CountAutomationItems: *fn (*TrackEnvelope env) callconv(.C) c_int;

/// CountEnvelopePoints
/// Returns the number of points in the envelope. See CountEnvelopePointsEx.
CountEnvelopePoints: *fn (*TrackEnvelope envelope) callconv(.C) c_int;

/// CountEnvelopePointsEx
/// Returns the number of points in the envelope.
/// autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
/// For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
/// even if the automation item is trimmed so that not all points are visible.
/// Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
/// See GetEnvelopePointEx, SetEnvelopePointEx, InsertEnvelopePointEx, DeleteEnvelopePointEx.
CountEnvelopePointsEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx) callconv(.C) c_int;

/// CountMediaItems
/// count the number of items in the project (proj=0 for active project)
CountMediaItems: *fn (*ReaProject proj) callconv(.C) c_int;

/// CountProjectMarkers
/// num_markersOut and num_regionsOut may be NULL.
CountProjectMarkers: *fn (*ReaProject proj, *c_int num_markersOut, *c_int num_regionsOut) callconv(.C) c_int;

/// CountSelectedMediaItems
/// count the number of selected items in the project (proj=0 for active project)
CountSelectedMediaItems: *fn (*ReaProject proj) callconv(.C) c_int;

/// CountSelectedTracks
/// Count the number of selected tracks in the project (proj=0 for active project). This function ignores the master track, see CountSelectedTracks2.
CountSelectedTracks: *fn (*ReaProject proj) callconv(.C) c_int;

/// CountSelectedTracks2
/// Count the number of selected tracks in the project (proj=0 for active project).
CountSelectedTracks2: *fn (*ReaProject proj, bool wantmaster) callconv(.C) c_int;

/// CountTakeEnvelopes
/// See GetTakeEnvelope
CountTakeEnvelopes: *fn (*MediaItem_Take take) callconv(.C) c_int;

/// CountTakes
/// count the number of takes in the item
CountTakes: *fn (*MediaItem item) callconv(.C) c_int;

/// CountTCPFXParms
/// Count the number of FX parameter knobs displayed on the track control panel.
CountTCPFXParms: *fn (*ReaProject project, *MediaTrack track) callconv(.C) c_int;

/// CountTempoTimeSigMarkers
/// Count the number of tempo/time signature markers in the project. See GetTempoTimeSigMarker, SetTempoTimeSigMarker, AddTempoTimeSigMarker.
CountTempoTimeSigMarkers: *fn (*ReaProject proj) callconv(.C) c_int;

/// CountTrackEnvelopes
/// see GetTrackEnvelope
CountTrackEnvelopes: *fn (*MediaTrack track) callconv(.C) c_int;

/// CountTrackMediaItems
/// count the number of items in the track
CountTrackMediaItems: *fn (*MediaTrack track) callconv(.C) c_int;

/// CountTracks
/// count the number of tracks in the project (proj=0 for active project)
CountTracks: *fn (*ReaProject projOptional) callconv(.C) c_int;

/// CreateLocalOscHandler
/// callback is a function pointer: void (*callback)(*void obj, const *c_char msg, c_int msglen), which handles OSC messages sent from REAPER. The function return is a local osc handler. See SendLocalOscMessage, DestroyOscHandler.
CreateLocalOscHandler: *fn (*void obj, *void callback) callconv(.C) *void;

/// CreateMIDIInput
/// Can only reliably create midi access for devices not already opened in prefs/MIDI, suitable for control surfaces etc.
CreateMIDIInput(c_int dev) callconv(.C) *midi *fn_Input ; //TODO check me

/// CreateMIDIOutput
/// Can only reliably create midi access for devices not already opened in prefs/MIDI, suitable for control surfaces etc. If streamMode is set, msoffset100 points to a persistent variable that can change and reflects added delay to output in 100ths of a millisecond.
CreateMIDIOutput(c_int dev, bool streamMode, *c_int msoffset100) callconv(.C) *midi *fn_Output ; //TODO check me

/// CreateNewMIDIItemInProj
/// Create a new MIDI media item, containing no MIDI events. Time is in seconds unless qn is set.
CreateNewMIDIItemInProj: *fn (*MediaTrack track, double starttime, double endtime, const *bool qnInOptional) callconv(.C) *MediaItem;

/// CreateTakeAudioAccessor
/// Create an audio accessor object for this take. Must only call from the main thread. See CreateTrackAudioAccessor, DestroyAudioAccessor, AudioAccessorStateChanged, GetAudioAccessorStartTime, GetAudioAccessorEndTime, GetAudioAccessorSamples.
CreateTakeAudioAccessor: *fn (*MediaItem_Take take) callconv(.C) *AudioAccessor;

/// CreateTrackAudioAccessor
/// Create an audio accessor object for this track. Must only call from the main thread. See CreateTakeAudioAccessor, DestroyAudioAccessor, AudioAccessorStateChanged, GetAudioAccessorStartTime, GetAudioAccessorEndTime, GetAudioAccessorSamples.
CreateTrackAudioAccessor: *fn (*MediaTrack track) callconv(.C) *AudioAccessor;

/// CreateTrackSend
/// Create a send/receive (desttrInOptional!=NULL), or a hardware output (desttrInOptional==NULL) with default properties, return >=0 on success (== new send/receive index). See RemoveTrackSend, GetSetTrackSendInfo, GetTrackSendInfo_Value, SetTrackSendInfo_Value.
CreateTrackSend: *fn (*MediaTrack tr, *MediaTrack desttrInOptional) callconv(.C) c_int;

/// CSurf_FlushUndo
/// call this to force flushing of the undo states after using *CSurf_OnChange()
CSurf_FlushUndo: *fn (bool force) callconv(.C) void;

/// CSurf_GetTouchState
CSurf_GetTouchState: *fn (*MediaTrack trackid, c_int isPan) callconv(.C) bool;

/// CSurf_GoEnd
CSurf_GoEnd: *fn () callconv(.C) void;

/// CSurf_GoStart
CSurf_GoStart: *fn () callconv(.C) void;

/// CSurf_NumTracks
CSurf_NumTracks: *fn (bool mcpView) callconv(.C) c_int;

/// CSurf_OnArrow
CSurf_OnArrow: *fn (c_int whichdir, bool wantzoom) callconv(.C) void;

/// CSurf_OnFwd
CSurf_OnFwd: *fn (c_int seekplay) callconv(.C) void;

/// CSurf_OnFXChange
CSurf_OnFXChange: *fn (*MediaTrack trackid, c_int en) callconv(.C) bool;

/// CSurf_OnInputMonitorChange
CSurf_OnInputMonitorChange: *fn (*MediaTrack trackid, c_int monitor) callconv(.C) c_int;

/// CSurf_OnInputMonitorChangeEx
CSurf_OnInputMonitorChangeEx: *fn (*MediaTrack trackid, c_int monitor, bool allowgang) callconv(.C) c_int;

/// CSurf_OnMuteChange
CSurf_OnMuteChange: *fn (*MediaTrack trackid, c_int mute) callconv(.C) bool;

/// CSurf_OnMuteChangeEx
CSurf_OnMuteChangeEx: *fn (*MediaTrack trackid, c_int mute, bool allowgang) callconv(.C) bool;

/// CSurf_OnOscControlMessage
CSurf_OnOscControlMessage: *fn (const *c_char msg, const *float arg) callconv(.C) void;

/// CSurf_OnOscControlMessage2
CSurf_OnOscControlMessage2: *fn (const *c_char msg, const *float arg, const *c_char argstr) callconv(.C) void;

/// CSurf_OnPanChange
CSurf_OnPanChange: *fn (*MediaTrack trackid, double pan, bool relative) callconv(.C) double;

/// CSurf_OnPanChangeEx
CSurf_OnPanChangeEx: *fn (*MediaTrack trackid, double pan, bool relative, bool allowGang) callconv(.C) double;

/// CSurf_OnPause
CSurf_OnPause: *fn () callconv(.C) void;

/// CSurf_OnPlay
CSurf_OnPlay: *fn () callconv(.C) void;

/// CSurf_OnPlayRateChange
CSurf_OnPlayRateChange: *fn (double playrate) callconv(.C) void;

/// CSurf_OnRecArmChange
CSurf_OnRecArmChange: *fn (*MediaTrack trackid, c_int recarm) callconv(.C) bool;

/// CSurf_OnRecArmChangeEx
CSurf_OnRecArmChangeEx: *fn (*MediaTrack trackid, c_int recarm, bool allowgang) callconv(.C) bool;

/// CSurf_OnRecord
CSurf_OnRecord: *fn () callconv(.C) void;

/// CSurf_OnRecvPanChange
CSurf_OnRecvPanChange: *fn (*MediaTrack trackid, c_int recv_index, double pan, bool relative) callconv(.C) double;

/// CSurf_OnRecvVolumeChange
CSurf_OnRecvVolumeChange: *fn (*MediaTrack trackid, c_int recv_index, double volume, bool relative) callconv(.C) double;

/// CSurf_OnRew
CSurf_OnRew: *fn (c_int seekplay) callconv(.C) void;

/// CSurf_OnRewFwd
CSurf_OnRewFwd: *fn (c_int seekplay, c_int dir) callconv(.C) void;

/// CSurf_OnScroll
CSurf_OnScroll: *fn (c_int xdir, c_int ydir) callconv(.C) void;

/// CSurf_OnSelectedChange
CSurf_OnSelectedChange: *fn (*MediaTrack trackid, c_int selected) callconv(.C) bool;

/// CSurf_OnSendPanChange
CSurf_OnSendPanChange: *fn (*MediaTrack trackid, c_int send_index, double pan, bool relative) callconv(.C) double;

/// CSurf_OnSendVolumeChange
CSurf_OnSendVolumeChange: *fn (*MediaTrack trackid, c_int send_index, double volume, bool relative) callconv(.C) double;

/// CSurf_OnSoloChange
CSurf_OnSoloChange: *fn (*MediaTrack trackid, c_int solo) callconv(.C) bool;

/// CSurf_OnSoloChangeEx
CSurf_OnSoloChangeEx: *fn (*MediaTrack trackid, c_int solo, bool allowgang) callconv(.C) bool;

/// CSurf_OnStop
CSurf_OnStop: *fn () callconv(.C) void;

/// CSurf_OnTempoChange
CSurf_OnTempoChange: *fn (double bpm) callconv(.C) void;

/// CSurf_OnTrackSelection
CSurf_OnTrackSelection: *fn (*MediaTrack trackid) callconv(.C) void;

/// CSurf_OnVolumeChange
CSurf_OnVolumeChange: *fn (*MediaTrack trackid, double volume, bool relative) callconv(.C) double;

/// CSurf_OnVolumeChangeEx
CSurf_OnVolumeChangeEx: *fn (*MediaTrack trackid, double volume, bool relative, bool allowGang) callconv(.C) double;

/// CSurf_OnWidthChange
CSurf_OnWidthChange: *fn (*MediaTrack trackid, double width, bool relative) callconv(.C) double;

/// CSurf_OnWidthChangeEx
CSurf_OnWidthChangeEx: *fn (*MediaTrack trackid, double width, bool relative, bool allowGang) callconv(.C) double;

/// CSurf_OnZoom
CSurf_OnZoom: *fn (c_int xdir, c_int ydir) callconv(.C) void;

/// CSurf_ResetAllCachedVolPanStates
CSurf_ResetAllCachedVolPanStates: *fn () callconv(.C) void;

/// CSurf_ScrubAmt
CSurf_ScrubAmt: *fn (double amt) callconv(.C) void;

/// CSurf_SetAutoMode
CSurf_SetAutoMode: *fn (c_int mode, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetPlayState
CSurf_SetPlayState: *fn (bool play, bool pause, bool rec, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetRepeatState
CSurf_SetRepeatState: *fn (bool rep, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetSurfaceMute
CSurf_SetSurfaceMute: *fn (*MediaTrack trackid, bool mute, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetSurfacePan
CSurf_SetSurfacePan: *fn (*MediaTrack trackid, double pan, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetSurfaceRecArm
CSurf_SetSurfaceRecArm: *fn (*MediaTrack trackid, bool recarm, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetSurfaceSelected
CSurf_SetSurfaceSelected: *fn (*MediaTrack trackid, bool selected, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetSurfaceSolo
CSurf_SetSurfaceSolo: *fn (*MediaTrack trackid, bool solo, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetSurfaceVolume
CSurf_SetSurfaceVolume: *fn (*MediaTrack trackid, double volume, *IReaperControlSurface ignoresurf) callconv(.C) void;

/// CSurf_SetTrackListChange
CSurf_SetTrackListChange: *fn () callconv(.C) void;

/// CSurf_TrackFromID
CSurf_TrackFromID: *fn (c_int idx, bool mcpView) callconv(.C) *MediaTrack;

/// CSurf_TrackToID
CSurf_TrackToID: *fn (*MediaTrack track, bool mcpView) callconv(.C) c_int;

/// DB2SLIDER
DB2SLIDER: *fn (double x) callconv(.C) double;

/// DeleteActionShortcut
/// Delete the specific shortcut for the given command ID.
/// See CountActionShortcuts, GetActionShortcutDesc, DoActionShortcutDialog.
DeleteActionShortcut: *fn (*KbdSectionInfo section, c_int cmdID, c_int shortcutidx) callconv(.C) bool;

/// DeleteEnvelopePointEx
/// Delete an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
/// autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
/// For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
/// even if the automation item is trimmed so that not all points are visible.
/// Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
/// See CountEnvelopePointsEx, GetEnvelopePointEx, SetEnvelopePointEx, InsertEnvelopePointEx.
DeleteEnvelopePointEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx, c_int ptidx) callconv(.C) bool;

/// DeleteEnvelopePointRange
/// Delete a range of envelope points. See DeleteEnvelopePointRangeEx, DeleteEnvelopePointEx.
DeleteEnvelopePointRange: *fn (*TrackEnvelope envelope, double time_start, double time_end) callconv(.C) bool;

/// DeleteEnvelopePointRangeEx
/// Delete a range of envelope points. autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
DeleteEnvelopePointRangeEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx, double time_start, double time_end) callconv(.C) bool;

/// DeleteExtState
/// Delete the extended state value for a specific section and key. persist=true means the value should remain deleted the next time REAPER is opened. See SetExtState, GetExtState, HasExtState.
DeleteExtState: *fn (const *c_char section, const *c_char key, bool persist) callconv(.C) void;

/// DeleteProjectMarker
/// Delete a marker.  proj==NULL for the active project.
DeleteProjectMarker: *fn (*ReaProject proj, c_int markrgnindexnumber, bool isrgn) callconv(.C) bool;

/// DeleteProjectMarkerByIndex
/// Differs from DeleteProjectMarker only in that markrgnidx is 0 for the first marker/region, 1 for the next, etc (see EnumProjectMarkers3), rather than representing the displayed marker/region ID number (see SetProjectMarker4).
DeleteProjectMarkerByIndex: *fn (*ReaProject proj, c_int markrgnidx) callconv(.C) bool;

/// DeleteTakeMarker
/// Delete a take marker. Note that idx will change for all following take markers. See GetNumTakeMarkers, GetTakeMarker, SetTakeMarker
DeleteTakeMarker: *fn (*MediaItem_Take take, c_int idx) callconv(.C) bool;

/// DeleteTakeStretchMarkers
/// Deletes one or more stretch markers. Returns number of stretch markers deleted.
DeleteTakeStretchMarkers: *fn (*MediaItem_Take take, c_int idx, const *c_int countInOptional) callconv(.C) c_int;

/// DeleteTempoTimeSigMarker
/// Delete a tempo/time signature marker.
DeleteTempoTimeSigMarker: *fn (*ReaProject project, c_int markerindex) callconv(.C) bool;

/// DeleteTrack
/// deletes a track
DeleteTrack: *fn (*MediaTrack tr) callconv(.C) void;

/// DeleteTrackMediaItem
DeleteTrackMediaItem: *fn (*MediaTrack tr, *MediaItem it) callconv(.C) bool;

/// DestroyAudioAccessor
/// Destroy an audio accessor. Must only call from the main thread. See CreateTakeAudioAccessor, CreateTrackAudioAccessor, AudioAccessorStateChanged, GetAudioAccessorStartTime, GetAudioAccessorEndTime, GetAudioAccessorSamples. 
DestroyAudioAccessor: *fn (*AudioAccessor accessor) callconv(.C) void;

/// DestroyLocalOscHandler
/// See CreateLocalOscHandler, SendLocalOscMessage.
DestroyLocalOscHandler: *fn (*void local_osc_handler) callconv(.C) void;

/// DoActionShortcutDialog
/// Open the action shortcut dialog to edit or add a shortcut for the given command ID. If (shortcutidx >= 0 && shortcutidx < CountActionShortcuts()), that specific shortcut will be replaced, otherwise a new shortcut will be added.
/// See CountActionShortcuts, GetActionShortcutDesc, DeleteActionShortcut.
DoActionShortcutDialog: *fn (HWND hwnd, *KbdSectionInfo section, c_int cmdID, c_int shortcutidx) callconv(.C) bool;

/// Dock_UpdateDockID
/// updates preference for docker window ident_str to be in dock whichDock on next open
Dock_UpdateDockID: *fn (const *c_char ident_str, c_int whichDock) callconv(.C) void;

/// DockGetPosition
/// -1=not found, 0=bottom, 1=left, 2=top, 3=right, 4=floating
DockGetPosition: *fn (c_int whichDock) callconv(.C) c_int;

/// DockIsChildOfDock
/// returns dock index that contains hwnd, or -1
DockIsChildOfDock: *fn (HWND hwnd, *bool isFloatingDockerOut) callconv(.C) c_int;

/// DockWindowActivate
DockWindowActivate: *fn (HWND hwnd) callconv(.C) void;

/// DockWindowAdd
DockWindowAdd: *fn (HWND hwnd, const *c_char name, c_int pos, bool allowShow) callconv(.C) void;

/// DockWindowAddEx
DockWindowAddEx: *fn (HWND hwnd, const *c_char name, const *c_char identstr, bool allowShow) callconv(.C) void;

/// DockWindowRefresh
DockWindowRefresh: *fn () callconv(.C) void;

/// DockWindowRefreshForHWND
DockWindowRefreshForHWND: *fn (HWND hwnd) callconv(.C) void;

/// DockWindowRemove
DockWindowRemove: *fn (HWND hwnd) callconv(.C) void;

/// DuplicateCustomizableMenu
/// Populate destmenu with all the entries and submenus found in srcmenu
DuplicateCustomizableMenu: *fn (*void srcmenu, *void destmenu) callconv(.C) bool;

/// EditTempoTimeSigMarker
/// Open the tempo/time signature marker editor dialog.
EditTempoTimeSigMarker: *fn (*ReaProject project, c_int markerindex) callconv(.C) bool;

/// EnsureNotCompletelyOffscreen
/// call with a saved window rect for your window and it'll correct any positioning info.
EnsureNotCompletelyOffscreen: *fn (*RECT rInOut) callconv(.C) void;

/// EnumerateFiles
/// List the files in the "path" directory. Returns NULL/nil when all files have been listed. Use fileindex = -1 to force re-read of directory (invalidate cache). See EnumerateSubdirectories
EnumerateFiles: *fn (const *c_char path, c_int fileindex) callconv(.C) const *c_char ; //TODO check me

/// EnumerateSubdirectories
/// List the subdirectories in the "path" directory. Use subdirindex = -1 to force re-read of directory (invalidate cache). Returns NULL/nil when all subdirectories have been listed. See EnumerateFiles
EnumerateSubdirectories: *fn (const *c_char path, c_int subdirindex) callconv(.C) const *c_char ; //TODO check me

/// EnumInstalledFX
/// Enumerates installed FX. Returns true if successful, sets nameOut and identOut to name and ident of FX at index.
EnumInstalledFX: *fn (c_int index, const *c_char* nameOut, const *c_char* identOut) callconv(.C) bool;

/// EnumPitchShiftModes
/// Start querying modes at 0, returns FALSE when no more modes possible, sets strOut to NULL if a mode is currently unsupported
EnumPitchShiftModes: *fn (c_int mode, const *c_char* strOut) callconv(.C) bool;

/// EnumPitchShiftSubModes
/// Returns submode name, or NULL
EnumPitchShiftSubModes: *fn (c_int mode, c_int submode) callconv(.C) const *c_char ; //TODO check me

/// EnumProjectMarkers
EnumProjectMarkers: *fn (c_int idx, *bool isrgnOut, *double posOut, *double rgnendOut, const *c_char* nameOut, *c_int markrgnindexnumberOut) callconv(.C) c_int;

/// EnumProjectMarkers2
EnumProjectMarkers2: *fn (*ReaProject proj, c_int idx, *bool isrgnOut, *double posOut, *double rgnendOut, const *c_char* nameOut, *c_int markrgnindexnumberOut) callconv(.C) c_int;

/// EnumProjectMarkers3
EnumProjectMarkers3: *fn (*ReaProject proj, c_int idx, *bool isrgnOut, *double posOut, *double rgnendOut, const *c_char* nameOut, *c_int markrgnindexnumberOut, *c_int colorOut) callconv(.C) c_int;

/// EnumProjects
/// idx=-1 for current project,projfn can be NULL if not interested in filename. use idx 0x40000000 for currently rendering project, if any.
EnumProjects: *fn (c_int idx, *c_char projfnOutOptional, c_int projfnOutOptional_sz) callconv(.C) *ReaProject;

/// EnumProjExtState
/// Enumerate the data stored with the project for a specific extname. Returns false when there is no more data. See SetProjExtState, GetProjExtState.
EnumProjExtState: *fn (*ReaProject proj, const *c_char extname, c_int idx, *c_char keyOutOptional, c_int keyOutOptional_sz, *c_char valOutOptional, c_int valOutOptional_sz) callconv(.C) bool;

/// EnumRegionRenderMatrix
/// Enumerate which tracks will be rendered within this region when using the region render matrix. When called with rendertrack==0, the function returns the first track that will be rendered (which may be the master track); rendertrack==1 will return the next track rendered, and so on. The function returns NULL when there are no more tracks that will be rendered within this region.
EnumRegionRenderMatrix: *fn (*ReaProject proj, c_int regionindex, c_int rendertrack) callconv(.C) *MediaTrack;

/// EnumTrackMIDIProgramNames
/// returns false if there are no plugins on the track that support MIDI programs,or if all programs have been enumerated
EnumTrackMIDIProgramNames: *fn (c_int track, c_int programNumber, *c_char programName, c_int programName_sz) callconv(.C) bool;

/// EnumTrackMIDIProgramNamesEx
/// returns false if there are no plugins on the track that support MIDI programs,or if all programs have been enumerated
EnumTrackMIDIProgramNamesEx: *fn (*ReaProject proj, *MediaTrack track, c_int programNumber, *c_char programName, c_int programName_sz) callconv(.C) bool;

/// Envelope_Evaluate
/// Get the effective envelope value at a given time position. samplesRequested is how long the caller expects until the next call to Envelope_Evaluate (often, the buffer block size). The return value is how many samples beyond that time position that the returned values are valid. dVdS is the change in value per sample (first derivative), ddVdS is the second derivative, dddVdS is the third derivative. See GetEnvelopeScalingMode.
Envelope_Evaluate: *fn (*TrackEnvelope envelope, double time, double samplerate, c_int samplesRequested, *double valueOut, *double dVdSOut, *double ddVdSOut, *double dddVdSOut) callconv(.C) c_int;

/// Envelope_FormatValue
/// Formats the value of an envelope to a user-readable form
Envelope_FormatValue: *fn (*TrackEnvelope env, double value, *c_char bufOut, c_int bufOut_sz) callconv(.C) void;

/// Envelope_GetParentTake
/// If take envelope, gets the take from the envelope. If FX, indexOut set to FX index, index2Out set to parameter index, otherwise -1.
Envelope_GetParentTake(*TrackEnvelope env, *c_int indexOut, *c_int index2Out) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// Envelope_GetParentTrack
/// If track envelope, gets the track from the envelope. If FX, indexOut set to FX index, index2Out set to parameter index, otherwise -1.
Envelope_GetParentTrack: *fn (*TrackEnvelope env, *c_int indexOut, *c_int index2Out) callconv(.C) *MediaTrack;

/// Envelope_SortPoints
/// Sort envelope points by time. See SetEnvelopePoint, InsertEnvelopePoint.
Envelope_SortPoints: *fn (*TrackEnvelope envelope) callconv(.C) bool;

/// Envelope_SortPointsEx
/// Sort envelope points by time. autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc. See SetEnvelopePoint, InsertEnvelopePoint.
Envelope_SortPointsEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx) callconv(.C) bool;

/// ExecProcess
/// Executes command line, returns NULL on total failure, otherwise the return value, a newline, and then the output of the command. If timeoutmsec is 0, command will be allowed to run indefinitely (recommended for large amounts of returned output). timeoutmsec is -1 for no wait/terminate, -2 for no wait and minimize
ExecProcess: *fn (const *c_char cmdline, c_int timeoutmsec) callconv(.C) const *c_char ; //TODO check me

/// file_exists
/// returns true if path points to a valid, readable file
file_exists: *fn (const *c_char path) callconv(.C) bool;

/// FindTempoTimeSigMarker
/// Find the tempo/time signature marker that falls at or before this time position (the marker that is in effect as of this time position).
FindTempoTimeSigMarker: *fn (*ReaProject project, double time) callconv(.C) c_int;

/// format_timestr
/// Format tpos (which is time in seconds) as hh:mm:ss.sss. See format_timestr_pos, format_timestr_len.
format_timestr: *fn (double tpos, *c_char buf, c_int buf_sz) callconv(.C) void;

/// format_timestr_len
/// time formatting mode overrides: -1=proj default.
/// 0=time
/// 1=measures.beats + time
/// 2=measures.beats
/// 3=seconds
/// 4=samples
/// 5=h:m:s:f
/// offset is start of where the length will be calculated from
format_timestr_len: *fn (double tpos, *c_char buf, c_int buf_sz, double offset, c_int modeoverride) callconv(.C) void;

/// format_timestr_pos
/// time formatting mode overrides: -1=proj default.
/// 0=time
/// 1=measures.beats + time
/// 2=measures.beats
/// 3=seconds
/// 4=samples
/// 5=h:m:s:f
/// 
format_timestr_pos: *fn (double tpos, *c_char buf, c_int buf_sz, c_int modeoverride) callconv(.C) void;

/// FreeHeapPtr
/// free heap memory returned from a Reaper API function
FreeHeapPtr: *fn (*void ptr) callconv(.C) void;

/// genGuid
genGuid: *fn (*GUID g) callconv(.C) void;

/// get_config_var
/// gets ini configuration variable by name, raw, returns size of variable in szOut and pointer to variable. special values queryable are also:
///   __numcpu (c_int) cpu count.
///   __fx_loadstate_ctx (c_char): 0 if unknown, or during FX state loading: 'u' (instantiating via undo), 'U' (updating via undo), 'P' (loading preset).
get_config_var: *fn (const *c_char name, *c_int szOut) callconv(.C) *void;

/// get_config_var_string
/// gets ini configuration variable value as string
get_config_var_string: *fn (const *c_char name, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// get_ini_file
/// Get reaper.ini full filename.
get_ini_file: *fn () callconv(.C) const *c_char ; //TODO check me

/// get_midi_config_var
/// Deprecated.
get_midi_config_var: *fn (const *c_char name, *c_int szOut) callconv(.C) *void;

/// GetActionShortcutDesc
/// Get the text description of a specific shortcut for the given command ID.
/// See CountActionShortcuts,DeleteActionShortcut,DoActionShortcutDialog.
GetActionShortcutDesc: *fn (*KbdSectionInfo section, c_int cmdID, c_int shortcutidx, *c_char descOut, c_int descOut_sz) callconv(.C) bool;

/// GetActiveTake
/// get the active take in this item
GetActiveTake(*MediaItem item) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// GetAllProjectPlayStates
/// returns the bitwise OR of all project play states (1=playing, 2=pause, 4=recording)
GetAllProjectPlayStates: *fn (*ReaProject ignoreProject) callconv(.C) c_int;

/// GetAppVersion
/// Returns app version which may include an OS/arch signifier, such as: "6.17" (windows 32-bit), "6.17/x64" (windows 64-bit), "6.17/OSX64" (macOS 64-bit Intel), "6.17/OSX" (macOS 32-bit), "6.17/macOS-arm64", "6.17/linux-x86_64", "6.17/linux-i686", "6.17/linux-aarch64", "6.17/linux-armv7l", etc
GetAppVersion: *fn () callconv(.C) const *c_char ; //TODO check me

/// GetArmedCommand
/// gets the currently armed command and section name (returns 0 if nothing armed). section name is empty-string for main section.
GetArmedCommand: *fn (*c_char secOut, c_int secOut_sz) callconv(.C) c_int;

/// GetAudioAccessorEndTime
/// Get the end time of the audio that can be returned from this accessor. See CreateTakeAudioAccessor, CreateTrackAudioAccessor, DestroyAudioAccessor, AudioAccessorStateChanged, GetAudioAccessorStartTime, GetAudioAccessorSamples.
GetAudioAccessorEndTime: *fn (*AudioAccessor accessor) callconv(.C) double;

/// GetAudioAccessorHash
/// Deprecated. See AudioAccessorStateChanged instead.
GetAudioAccessorHash: *fn (*AudioAccessor accessor, *c_char hashNeed128) callconv(.C) void;

/// GetAudioAccessorSamples
/// Get a block of samples from the audio accessor. Samples are extracted immediately pre-FX, and returned interleaved (first sample of first channel, first sample of second channel...). Returns 0 if no audio, 1 if audio, -1 on error. See CreateTakeAudioAccessor, CreateTrackAudioAccessor, DestroyAudioAccessor, AudioAccessorStateChanged, GetAudioAccessorStartTime, GetAudioAccessorEndTime.// 
/// 
/// This function has special handling in Python, and only returns two objects, the API function return value, and the sample buffer. Example usage:
/// 
/// <code>tr = RPR_GetTrack(0, 0)
/// aa = RPR_CreateTrackAudioAccessor(tr)
/// buf = list([0]*2*1024) # 2 channels, 1024 samples each, initialized to zero
/// pos = 0.0
/// (ret, buf) = GetAudioAccessorSamples(aa, 44100, 2, pos, 1024, buf)
/// # buf now holds the first 2*1024 audio samples from the track.
/// # typically GetAudioAccessorSamples() would be called within a loop, increasing pos each time.
/// </code>
GetAudioAccessorSamples: *fn (*AudioAccessor accessor, c_int samplerate, c_int numchannels, double starttime_sec, c_int numsamplesperchannel, *double samplebuffer) callconv(.C) c_int;

/// GetAudioAccessorStartTime
/// Get the start time of the audio that can be returned from this accessor. See CreateTakeAudioAccessor, CreateTrackAudioAccessor, DestroyAudioAccessor, AudioAccessorStateChanged, GetAudioAccessorEndTime, GetAudioAccessorSamples.
GetAudioAccessorStartTime: *fn (*AudioAccessor accessor) callconv(.C) double;

/// GetAudioDeviceInfo
/// get information about the currently open audio device. attribute can be MODE, IDENT_IN, IDENT_OUT, BSIZE, SRATE, BPS. returns false if unknown attribute or device not open.
GetAudioDeviceInfo: *fn (const *c_char attribute, *c_char descOut, c_int descOut_sz) callconv(.C) bool;

/// GetColorTheme
/// Deprecated, see GetColorThemeStruct.
GetColorTheme(c_int idx, c_int defval) callconv(.C) c_int *fn_PTR ; //TODO check me

/// GetColorThemeStruct
/// returns the whole color theme (icontheme.h) and the size
GetColorThemeStruct: *fn (*c_int szOut) callconv(.C) *void;

/// GetConfigWantsDock
/// gets the dock ID desired by ident_str, if any
GetConfigWantsDock: *fn (const *c_char ident_str) callconv(.C) c_int;

/// GetContextMenu
/// gets context menus. submenu 0:trackctl, 1:mediaitems, 2:ruler, 3:empty track area
GetContextMenu: *fn (c_int idx) callconv(.C) HMENU;

/// GetCurrentProjectInLoadSave
/// returns current project if in load/save (usually only used from project_config_extension_t)
GetCurrentProjectInLoadSave: *fn () callconv(.C) *ReaProject;

/// GetCursorContext
/// return the current cursor context: 0 if track panels, 1 if items, 2 if envelopes, otherwise unknown
GetCursorContext: *fn () callconv(.C) c_int;

/// GetCursorContext2
/// 0 if track panels, 1 if items, 2 if envelopes, otherwise unknown (unlikely when want_last_valid is true)
GetCursorContext2: *fn (bool want_last_valid) callconv(.C) c_int;

/// GetCursorPosition
/// edit cursor position
GetCursorPosition: *fn () callconv(.C) double;

/// GetCursorPositionEx
/// edit cursor position
GetCursorPositionEx: *fn (*ReaProject proj) callconv(.C) double;

/// GetDisplayedMediaItemColor
/// see GetDisplayedMediaItemColor2.
GetDisplayedMediaItemColor: *fn (*MediaItem item) callconv(.C) c_int;

/// GetDisplayedMediaItemColor2
/// Returns the custom take, item, or track color that is used (according to the user preference) to color the media item. The returned color is OS dependent|0x01000000 (i.e. ColorToNative(r,g,b)|0x01000000), so a return of zero means "no color", not black.
GetDisplayedMediaItemColor2: *fn (*MediaItem item, *MediaItem_Take take) callconv(.C) c_int;

/// GetEnvelopeInfo_Value
/// Gets an envelope numerical-value attribute:
/// I_TCPY : c_int : Y offset of envelope relative to parent track (may be separate lane or overlap with track contents)
/// I_TCPH : c_int : visible height of envelope
/// I_TCPY_USED : c_int : Y offset of envelope relative to parent track, exclusive of padding
/// I_TCPH_USED : c_int : visible height of envelope, exclusive of padding
/// P_TRACK : MediaTrack * : parent track pointer (if any)
/// P_DESTTRACK : MediaTrack * : destination track pointer, if on a send
/// P_ITEM : MediaItem * : parent item pointer (if any)
/// P_TAKE : MediaItem_Take * : parent take pointer (if any)
/// I_SEND_IDX : c_int : 1-based index of send in P_TRACK, or 0 if not a send
/// I_HWOUT_IDX : c_int : 1-based index of hardware output in P_TRACK or 0 if not a hardware output
/// I_RECV_IDX : c_int : 1-based index of receive in P_DESTTRACK or 0 if not a send/receive
/// 
GetEnvelopeInfo_Value: *fn (*TrackEnvelope env, const *c_char parmname) callconv(.C) double;

/// GetEnvelopeName
GetEnvelopeName: *fn (*TrackEnvelope env, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// GetEnvelopePoint
/// Get the attributes of an envelope point. See GetEnvelopePointEx.
GetEnvelopePoint: *fn (*TrackEnvelope envelope, c_int ptidx, *double timeOut, *double valueOut, *c_int shapeOut, *double tensionOut, *bool selectedOut) callconv(.C) bool;

/// GetEnvelopePointByTime
/// Returns the envelope point at or immediately prior to the given time position. See GetEnvelopePointByTimeEx.
GetEnvelopePointByTime: *fn (*TrackEnvelope envelope, double time) callconv(.C) c_int;

/// GetEnvelopePointByTimeEx
/// Returns the envelope point at or immediately prior to the given time position.
/// autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
/// For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
/// even if the automation item is trimmed so that not all points are visible.
/// Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
/// See GetEnvelopePointEx, SetEnvelopePointEx, InsertEnvelopePointEx, DeleteEnvelopePointEx.
GetEnvelopePointByTimeEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx, double time) callconv(.C) c_int;

/// GetEnvelopePointEx
/// Get the attributes of an envelope point.
/// autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
/// For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
/// even if the automation item is trimmed so that not all points are visible.
/// Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
/// See CountEnvelopePointsEx, SetEnvelopePointEx, InsertEnvelopePointEx, DeleteEnvelopePointEx.
GetEnvelopePointEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx, c_int ptidx, *double timeOut, *double valueOut, *c_int shapeOut, *double tensionOut, *bool selectedOut) callconv(.C) bool;

/// GetEnvelopeScalingMode
/// Returns the envelope scaling mode: 0=no scaling, 1=fader scaling. All API functions deal with raw envelope point values, to convert raw from/to scaled values see ScaleFromEnvelopeMode, ScaleToEnvelopeMode.
GetEnvelopeScalingMode: *fn (*TrackEnvelope env) callconv(.C) c_int;

/// GetEnvelopeStateChunk
/// Gets the RPPXML state of an envelope, returns true if successful. Undo flag is a performance/caching hint.
GetEnvelopeStateChunk: *fn (*TrackEnvelope env, *c_char strNeedBig, c_int strNeedBig_sz, bool isundoOptional) callconv(.C) bool;

/// GetEnvelopeUIState
/// gets information on the UI state of an envelope: returns &1 if automation/modulation is playing back, &2 if automation is being actively written, &4 if the envelope recently had an effective automation mode change
GetEnvelopeUIState: *fn (*TrackEnvelope env) callconv(.C) c_int;

/// GetExePath
/// returns path of REAPER.exe (not including EXE), i.e. C:\Program Files\REAPER
GetExePath: *fn () callconv(.C) const *c_char ; //TODO check me

/// GetExtState
/// Get the extended state value for a specific section and key. See SetExtState, DeleteExtState, HasExtState.
GetExtState: *fn (const *c_char section, const *c_char key) callconv(.C) const *c_char ; //TODO check me

/// GetFocusedFX
/// This function is deprecated (returns GetFocusedFX2()&3), see GetTouchedOrFocusedFX.
GetFocusedFX: *fn (*c_int tracknumberOut, *c_int itemnumberOut, *c_int fxnumberOut) callconv(.C) c_int;

/// GetFocusedFX2
/// Return value has 1 set if track FX, 2 if take/item FX, 4 set if FX is no longer focused but still open. tracknumber==0 means the master track, 1 means track 1, etc. itemnumber is zero-based (or -1 if not an item). For interpretation of fxnumber, see GetLastTouchedFX. Deprecated, see GetTouchedOrFocusedFX
GetFocusedFX2: *fn (*c_int tracknumberOut, *c_int itemnumberOut, *c_int fxnumberOut) callconv(.C) c_int;

/// GetFreeDiskSpaceForRecordPath
/// returns free disk space in megabytes, pathIdx 0 for normal, 1 for alternate.
GetFreeDiskSpaceForRecordPath: *fn (*ReaProject proj, c_int pathidx) callconv(.C) c_int;

/// GetFXEnvelope
/// Returns the FX parameter envelope. If the envelope does not exist and create=true, the envelope will be created. If the envelope already exists and is bypassed and create=true, then the envelope will be unbypassed.
GetFXEnvelope: *fn (*MediaTrack track, c_int fxindex, c_int parameterindex, bool create) callconv(.C) *TrackEnvelope;

/// GetGlobalAutomationOverride
/// return -1=no override, 0=trim/read, 1=read, 2=touch, 3=write, 4=latch, 5=bypass
GetGlobalAutomationOverride: *fn () callconv(.C) c_int;

/// GetHZoomLevel
/// returns pixels/second
GetHZoomLevel: *fn () callconv(.C) double;

/// GetIconThemePointer
/// returns a named icontheme entry
GetIconThemePointer: *fn (const *c_char name) callconv(.C) *void;

/// GetIconThemePointerForDPI
/// returns a named icontheme entry for a given DPI-scaling (256=1:1). Note: the return value should not be stored, it should be queried at each paint! Querying name=NULL returns the start of the structure
GetIconThemePointerForDPI: *fn (const *c_char name, c_int dpisc) callconv(.C) *void;

/// GetIconThemeStruct
/// returns a pointer to the icon theme (icontheme.h) and the size of that struct
GetIconThemeStruct: *fn (*c_int szOut) callconv(.C) *void;

/// GetInputActivityLevel
/// returns approximate input level if available, 0-511 mono inputs, |1024 for stereo pairs, 4096+*devidx32 for MIDI devices
GetInputActivityLevel: *fn (c_int input_id) callconv(.C) double;

/// GetInputChannelName
GetInputChannelName: *fn (c_int channelIndex) callconv(.C) const *c_char ; //TODO check me

/// GetInputOutputLatency
/// Gets the audio device input/output latency in samples
GetInputOutputLatency: *fn (*c_int inputlatencyOut, *c_int outputLatencyOut) callconv(.C) void;

/// GetItemEditingTime2
/// returns time of relevant edit, set which_item to the pcm_source (if applicable), flags (if specified) will be set to 1 for edge resizing, 2 for fade change, 4 for item move, 8 for item slip edit (edit cursor time or start of item)
GetItemEditingTime2: *fn (*PCM_source* which_itemOut, *c_int flagsOut) callconv(.C) double;

/// GetItemFromPoint
/// Returns the first item at the screen coordinates specified. If allow_locked is false, locked items are ignored. If takeOutOptional specified, returns the take hit. See GetThingFromPoint.
GetItemFromPoint: *fn (c_int screen_x, c_int screen_y, bool allow_locked, *MediaItem_Take* takeOutOptional) callconv(.C) *MediaItem;

/// GetItemProjectContext
GetItemProjectContext: *fn (*MediaItem item) callconv(.C) *ReaProject;

/// GetItemStateChunk
/// Gets the RPPXML state of an item, returns true if successful. Undo flag is a performance/caching hint.
GetItemStateChunk: *fn (*MediaItem item, *c_char strNeedBig, c_int strNeedBig_sz, bool isundoOptional) callconv(.C) bool;

/// GetLastColorThemeFile
GetLastColorThemeFile: *fn () callconv(.C) const *c_char ; //TODO check me

/// GetLastMarkerAndCurRegion
/// Get the last project marker before time, and/or the project region that includes time. markeridx and regionidx are returned not necessarily as the displayed marker/region index, but as the index that can be passed to EnumProjectMarkers. Either or both of markeridx and regionidx may be NULL. See EnumProjectMarkers.
GetLastMarkerAndCurRegion: *fn (*ReaProject proj, double time, *c_int markeridxOut, *c_int regionidxOut) callconv(.C) void;

/// GetLastTouchedFX
/// Returns true if the last touched FX parameter is valid, false otherwise. The low word of tracknumber is the 1-based track index -- 0 means the master track, 1 means track 1, etc. If the high word of tracknumber is nonzero, it refers to the 1-based item index (1 is the first item on the track, etc). For track FX, the low 24 bits of fxnumber refer to the FX index in the chain, and if the next 8 bits are 01, then the FX is record FX. For item FX, the low word defines the FX index in the chain, and the high word defines the take number. Deprecated, see GetTouchedOrFocusedFX.
GetLastTouchedFX: *fn (*c_int tracknumberOut, *c_int fxnumberOut, *c_int paramnumberOut) callconv(.C) bool;

/// GetLastTouchedTrack
GetLastTouchedTrack: *fn () callconv(.C) *MediaTrack;

/// GetMainHwnd
GetMainHwnd: *fn () callconv(.C) HWND;

/// GetMasterMuteSoloFlags
/// &1=master mute,&2=master solo. This is deprecated as you can just query the master track as well.
GetMasterMuteSoloFlags: *fn () callconv(.C) c_int;

/// GetMasterTrack
GetMasterTrack: *fn (*ReaProject proj) callconv(.C) *MediaTrack;

/// GetMasterTrackVisibility
/// returns &1 if the master track is visible in the TCP, &2 if NOT visible in the mixer. See SetMasterTrackVisibility.
GetMasterTrackVisibility: *fn () callconv(.C) c_int;

/// GetMaxMidiInputs
/// returns max dev for midi inputs/outputs
GetMaxMidiInputs: *fn () callconv(.C) c_int;

/// GetMaxMidiOutputs
GetMaxMidiOutputs: *fn () callconv(.C) c_int;

/// GetMediaFileMetadata
/// Get text-based metadata from a media file for a given identifier. Call with identifier="" to list all identifiers contained in the file, separated by newlines. May return "[Binary data]" for metadata that REAPER doesn't handle.
GetMediaFileMetadata: *fn (*PCM_source mediaSource, const *c_char identifier, *c_char bufOutNeedBig, c_int bufOutNeedBig_sz) callconv(.C) c_int;

/// GetMediaItem
/// get an item from a project by item count (zero-based) (proj=0 for active project)
GetMediaItem: *fn (*ReaProject proj, c_int itemidx) callconv(.C) *MediaItem;

/// GetMediaItem_Track
/// Get parent track of media item
GetMediaItem_Track: *fn (*MediaItem item) callconv(.C) *MediaTrack;

/// GetMediaItemInfo_Value
/// Get media item numerical-value attributes.
/// B_MUTE : bool * : muted (item solo overrides). setting this value will clear C_MUTE_SOLO.
/// B_MUTE_ACTUAL : bool * : muted (ignores solo). setting this value will not affect C_MUTE_SOLO.
/// C_LANEPLAYS : c_char * : in fixed lane tracks, 0=this item lane does not play, 1=this item lane plays exclusively, 2=this item lane plays and other lanes also play, -1=this item is on a non-visible, non-playing lane on a non-fixed-lane track (read-only)
/// C_MUTE_SOLO : c_char * : solo override (-1=soloed, 0=no override, 1=unsoloed). note that this API does not automatically unsolo other items when soloing (nor clear the unsolos when clearing the last soloed item), it must be done by the caller via action or via this API.
/// B_LOOPSRC : bool * : loop source
/// B_ALLTAKESPLAY : bool * : all takes play
/// B_UISEL : bool * : selected in arrange view
/// C_BEATATTACHMODE : c_char * : item timebase, -1=track or project default, 1=beats (position, length, rate), 2=beats (position only). for auto-stretch timebase: C_BEATATTACHMODE=1, C_AUTOSTRETCH=1
/// C_AUTOSTRETCH: : c_char * : auto-stretch at project tempo changes, 1=enabled, requires C_BEATATTACHMODE=1
/// C_LOCK : c_char * : locked, &1=locked
/// D_VOL : double * : item volume,  0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
/// D_POSITION : double * : item position in seconds
/// D_LENGTH : double * : item length in seconds
/// D_SNAPOFFSET : double * : item snap offset in seconds
/// D_FADEINLEN : double * : item manual fadein length in seconds
/// D_FADEOUTLEN : double * : item manual fadeout length in seconds
/// D_FADEINDIR : double * : item fadein curvature, -1..1
/// D_FADEOUTDIR : double * : item fadeout curvature, -1..1
/// D_FADEINLEN_AUTO : double * : item auto-fadein length in seconds, -1=no auto-fadein
/// D_FADEOUTLEN_AUTO : double * : item auto-fadeout length in seconds, -1=no auto-fadeout
/// C_FADEINSHAPE : c_int * : fadein shape, 0..6, 0=linear
/// C_FADEOUTSHAPE : c_int * : fadeout shape, 0..6, 0=linear
/// I_GROUPID : c_int * : group ID, 0=no group
/// I_LASTY : c_int * : Y-position (relative to top of track) in pixels (read-only)
/// I_LASTH : c_int * : height in pixels (read-only)
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// I_CURTAKE : c_int * : active take number
/// IP_ITEMNUMBER : c_int : item number on this track (read-only, returns the item number directly)
/// F_FREEMODE_Y : float * : free item positioning or fixed lane Y-position. 0=top of track, 1.0=bottom of track
/// F_FREEMODE_H : float * : free item positioning or fixed lane height. 0.5=half the track height, 1.0=full track height
/// I_FIXEDLANE : c_int * : fixed lane of item (fine to call with setNewValue, but returned value is read-only)
/// B_FIXEDLANE_HIDDEN : bool * : true if displaying only one fixed lane and this item is in a different lane (read-only)
/// P_TRACK : MediaTrack * : (read-only)
/// 
GetMediaItemInfo_Value: *fn (*MediaItem item, const *c_char parmname) callconv(.C) double;

/// GetMediaItemNumTakes
GetMediaItemNumTakes: *fn (*MediaItem item) callconv(.C) c_int;

/// GetMediaItemTake
GetMediaItemTake(*MediaItem item, c_int tk) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// GetMediaItemTake_Item
/// Get parent item of media item take
GetMediaItemTake_Item: *fn (*MediaItem_Take take) callconv(.C) *MediaItem;

/// GetMediaItemTake_Peaks
/// Gets block of peak samples to buf. Note that the peak samples are interleaved, but in two or three blocks (maximums, then minimums, then extra). Return value has 20 bits of returned sample count, then 4 bits of output_mode (0xf00000), then a bit to signify whether extra_type was available (0x1000000). extra_type can be 115 ('s') for spectral information, which will return peak samples as integers with the low 15 bits frequency, next 14 bits tonality.
GetMediaItemTake_Peaks: *fn (*MediaItem_Take take, double peakrate, double starttime, c_int numchannels, c_int numsamplesperchannel, c_int want_extra_type, *double buf) callconv(.C) c_int;

/// GetMediaItemTake_Source
/// Get media source of media item take
GetMediaItemTake_Source(*MediaItem_Take take) callconv(.C) *PCM *fn_source ; //TODO check me

/// GetMediaItemTake_Track
/// Get parent track of media item take
GetMediaItemTake_Track: *fn (*MediaItem_Take take) callconv(.C) *MediaTrack;

/// GetMediaItemTakeByGUID
GetMediaItemTakeByGUID(*ReaProject project, const *GUID guid) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// GetMediaItemTakeInfo_Value
/// Get media item take numerical-value attributes.
/// D_STARTOFFS : double * : start offset in source media, in seconds
/// D_VOL : double * : take volume, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc, negative if take polarity is flipped
/// D_PAN : double * : take pan, -1..1
/// D_PANLAW : double * : take pan law, -1=default, 0.5=-6dB, 1.0=+0dB, etc
/// D_PLAYRATE : double * : take playback rate, 0.5=half speed, 1=normal, 2=double speed, etc
/// D_PITCH : double * : take pitch adjustment in semitones, -12=one octave down, 0=normal, +12=one octave up, etc
/// B_PPITCH : bool * : preserve pitch when changing playback rate
/// I_LASTY : c_int * : Y-position (relative to top of track) in pixels (read-only)
/// I_LASTH : c_int * : height in pixels (read-only)
/// I_CHANMODE : c_int * : channel mode, 0=normal, 1=reverse stereo, 2=downmix, 3=left, 4=right
/// I_PITCHMODE : c_int * : pitch shifter mode, -1=project default, otherwise high 2 bytes=shifter, low 2 bytes=parameter
/// I_STRETCHFLAGS : c_int * : stretch marker flags (&7 mask for mode override: 0=default, 1=balanced, 2/3/6=tonal, 4=transient, 5=no pre-echo)
/// F_STRETCHFADESIZE : float * : stretch marker fade size in seconds (0.0025 default)
/// I_RECPASSID : c_int * : record pass ID
/// I_TAKEFX_NCH : c_int * : number of internal audio channels for per-take FX to use (OK to call with setNewValue, but the returned value is read-only)
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// IP_TAKENUMBER : c_int : take number (read-only, returns the take number directly)
/// P_TRACK : pointer to MediaTrack (read-only)
/// P_ITEM : pointer to MediaItem (read-only)
/// P_SOURCE : PCM_source *. Note that if setting this, you should first retrieve the old source, set the new, THEN delete the old.
/// 
GetMediaItemTakeInfo_Value: *fn (*MediaItem_Take take, const *c_char parmname) callconv(.C) double;

/// GetMediaItemTrack
GetMediaItemTrack: *fn (*MediaItem item) callconv(.C) *MediaTrack;

/// GetMediaSourceFileName
/// Copies the media source filename to filenamebuf. Note that in-project MIDI media sources have no associated filename. See GetMediaSourceParent.
GetMediaSourceFileName: *fn (*PCM_source source, *c_char filenamebufOut, c_int filenamebufOut_sz) callconv(.C) void;

/// GetMediaSourceLength
/// Returns the length of the source media. If the media source is beat-based, the length will be in quarter notes, otherwise it will be in seconds.
GetMediaSourceLength: *fn (*PCM_source source, *bool lengthIsQNOut) callconv(.C) double;

/// GetMediaSourceNumChannels
/// Returns the number of channels in the source media.
GetMediaSourceNumChannels: *fn (*PCM_source source) callconv(.C) c_int;

/// GetMediaSourceParent
/// Returns the parent source, or NULL if src is the root source. This can be used to retrieve the parent properties of sections or reversed sources for example.
GetMediaSourceParent(*PCM_source src) callconv(.C) *PCM *fn_source ; //TODO check me

/// GetMediaSourceSampleRate
/// Returns the sample rate. MIDI source media will return zero.
GetMediaSourceSampleRate: *fn (*PCM_source source) callconv(.C) c_int;

/// GetMediaSourceType
/// copies the media source type ("WAV", "MIDI", etc) to typebuf
GetMediaSourceType: *fn (*PCM_source source, *c_char typebufOut, c_int typebufOut_sz) callconv(.C) void;

/// GetMediaTrackInfo_Value
/// Get track numerical-value attributes.
/// B_MUTE : bool * : muted
/// B_PHASE : bool * : track phase inverted
/// B_RECMON_IN_EFFECT : bool * : record monitoring in effect (current audio-thread playback state, read-only)
/// IP_TRACKNUMBER : c_int : track number 1-based, 0=not found, -1=master track (read-only, returns the c_int directly)
/// I_SOLO : c_int * : soloed, 0=not soloed, 1=soloed, 2=soloed in place, 5=safe soloed, 6=safe soloed in place
/// B_SOLO_DEFEAT : bool * : when set, if anything else is soloed and this track is not muted, this track acts soloed
/// I_FXEN : c_int * : fx enabled, 0=bypassed, !0=fx active
/// I_RECARM : c_int * : record armed, 0=not record armed, 1=record armed
/// I_RECINPUT : c_int * : record input, <0=no input. if 4096 set, input is MIDI and low 5 bits represent channel (0=all, 1-16=only chan), next 6 bits represent physical input (63=all, 62=VKB). If 4096 is not set, low 10 bits (0..1023) are input start channel (ReaRoute/Loopback start at 512). If 2048 is set, input is multichannel input (using track channel count), or if 1024 is set, input is stereo input, otherwise input is mono.
/// I_RECMODE : c_int * : record mode, 0=input, 1=stereo out, 2=none, 3=stereo out w/latency compensation, 4=midi output, 5=mono out, 6=mono out w/ latency compensation, 7=midi overdub, 8=midi replace
/// I_RECMODE_FLAGS : c_int * : record mode flags, &3=output recording mode (0=post fader, 1=pre-fx, 2=post-fx/pre-fader)
/// I_RECMON : c_int * : record monitoring, 0=off, 1=normal, 2=not when playing (tape style)
/// I_RECMONITEMS : c_int * : monitor items while recording, 0=off, 1=on
/// B_AUTO_RECARM : bool * : automatically set record arm when selected (does not immediately affect recarm state, script should set directly if desired)
/// I_VUMODE : c_int * : track vu mode, &1:disabled, &30==0:stereo peaks, &30==2:multichannel peaks, &30==4:stereo RMS, &30==8:combined RMS, &30==12:LUFS-M, &30==16:LUFS-S (readout=max), &30==20:LUFS-S (readout=current), &32:LUFS calculation on channels 1+2 only
/// I_AUTOMODE : c_int * : track automation mode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch
/// I_NCHAN : c_int * : number of track channels, 2-128, even numbers only
/// I_SELECTED : c_int * : track selected, 0=unselected, 1=selected
/// I_WNDH : c_int * : current TCP window height in pixels including envelopes (read-only)
/// I_TCPH : c_int * : current TCP window height in pixels not including envelopes (read-only)
/// I_TCPY : c_int * : current TCP window Y-position in pixels relative to top of arrange view (read-only)
/// I_MCPX : c_int * : current MCP X-position in pixels relative to mixer container (read-only)
/// I_MCPY : c_int * : current MCP Y-position in pixels relative to mixer container (read-only)
/// I_MCPW : c_int * : current MCP width in pixels (read-only)
/// I_MCPH : c_int * : current MCP height in pixels (read-only)
/// I_FOLDERDEPTH : c_int * : folder depth change, 0=normal, 1=track is a folder parent, -1=track is the last in the innermost folder, -2=track is the last in the innermost and next-innermost folders, etc
/// I_FOLDERCOMPACT : c_int * : folder collapsed state (only valid on folders), 0=normal, 1=collapsed, 2=fully collapsed
/// I_MIDIHWOUT : c_int * : track midi hardware output index, <0=disabled, low 5 bits are which channels (0=all, 1-16), next 5 bits are output device index (0-31)
/// I_MIDI_INPUT_CHANMAP : c_int * : -1 maps to source channel, otherwise 1-16 to map to MIDI channel
/// I_MIDI_CTL_CHAN : c_int * : -1 no link, 0-15 link to MIDI volume/pan on channel, 16 link to MIDI volume/pan on all channels
/// I_MIDI_TRACKSEL_FLAG : c_int * : MIDI editor track list options: &1=expand media items, &2=exclude from list, &4=auto-pruned
/// I_PERFFLAGS : c_int * : track performance flags, &1=no media buffering, &2=no anticipative FX
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// I_HEIGHTOVERRIDE : c_int * : custom height override for TCP window, 0 for none, otherwise size in pixels
/// I_SPACER : c_int * : 1=TCP track spacer above this trackB_HEIGHTLOCK : bool * : track height lock (must set I_HEIGHTOVERRIDE before locking)
/// D_VOL : double * : trim volume of track, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
/// D_PAN : double * : trim pan of track, -1..1
/// D_WIDTH : double * : width of track, -1..1
/// D_DUALPANL : double * : dualpan position 1, -1..1, only if I_PANMODE==6
/// D_DUALPANR : double * : dualpan position 2, -1..1, only if I_PANMODE==6
/// I_PANMODE : c_int * : pan mode, 0=classic 3.x, 3=new balance, 5=stereo pan, 6=dual pan
/// D_PANLAW : double * : pan law of track, <0=project default, 0.5=-6dB, 0.707..=-3dB, 1=+0dB, 1.414..=-3dB with gain compensation, 2=-6dB with gain compensation, etc
/// I_PANLAW_FLAGS : c_int * : pan law flags, 0=sine taper, 1=hybrid taper with deprecated behavior when gain compensation enabled, 2=linear taper, 3=hybrid taper
/// P_ENV:<envchunkname or P_ENV:{GUID... : TrackEnvelope * : (read-only) chunkname can be <VOLENV, <PANENV, etc; GUID is the stringified envelope GUID.
/// B_SHOWINMIXER : bool * : track control panel visible in mixer (do not use on master track)
/// B_SHOWINTCP : bool * : track control panel visible in arrange view (do not use on master track)
/// B_MAINSEND : bool * : track sends audio to parent
/// C_MAINSEND_OFFS : c_char * : channel offset of track send to parent
/// C_MAINSEND_NCH : c_char * : channel count of track send to parent (0=use all child track channels, 1=use one channel only)
/// I_FREEMODE : c_int * : 1=track free item positioning enabled, 2=track fixed lanes enabled (call UpdateTimeline() after changing)
/// I_NUMFIXEDLANES : c_int * : number of track fixed lanes (fine to call with setNewValue, but returned value is read-only)
/// C_LANESCOLLAPSED : c_char * : fixed lane collapse state (1=lanes collapsed, 2=track displays as non-fixed-lanes but hidden lanes exist)
/// C_LANESETTINGS : c_char * : fixed lane settings (&1=auto-remove empty lanes at bottom, &2=do not auto-comp new recording, &4=newly recorded lanes play exclusively (else add lanes in layers), &8=big lanes (else small lanes), &16=add new recording at bottom (else record into first available lane), &32=hide lane buttons
/// C_LANEPLAYS:N : c_char * :  on fixed lane tracks, 0=lane N does not play, 1=lane N plays exclusively, 2=lane N plays and other lanes also play (fine to call with setNewValue, but returned value is read-only)
/// C_ALLLANESPLAY : c_char * : on fixed lane tracks, 0=no lanes play, 1=all lanes play, 2=some lanes play (fine to call with setNewValue 0 or 1, but returned value is read-only)
/// C_BEATATTACHMODE : c_char * : track timebase, -1=project default, 0=time, 1=beats (position, length, rate), 2=beats (position only)
/// F_MCP_FXSEND_SCALE : float * : scale of fx+send area in MCP (0=minimum allowed, 1=maximum allowed)
/// F_MCP_FXPARM_SCALE : float * : scale of fx parameter area in MCP (0=minimum allowed, 1=maximum allowed)
/// F_MCP_SENDRGN_SCALE : float * : scale of send area as proportion of the fx+send total area (0=minimum allowed, 1=maximum allowed)
/// F_TCP_FXPARM_SCALE : float * : scale of TCP parameter area when TCP FX are embedded (0=min allowed, default, 1=max allowed)
/// I_PLAY_OFFSET_FLAG : c_int * : track media playback offset state, &1=bypassed, &2=offset value is measured in samples (otherwise measured in seconds)
/// D_PLAY_OFFSET : double * : track media playback offset, units depend on I_PLAY_OFFSET_FLAG
/// P_PARTRACK : MediaTrack * : parent track (read-only)
/// P_PROJECT : ReaProject * : parent project (read-only)
/// 
GetMediaTrackInfo_Value: *fn (*MediaTrack tr, const *c_char parmname) callconv(.C) double;

/// GetMIDIInputName
/// returns true if device present
GetMIDIInputName: *fn (c_int dev, *c_char nameout, c_int nameout_sz) callconv(.C) bool;

/// GetMIDIOutputName
/// returns true if device present
GetMIDIOutputName: *fn (c_int dev, *c_char nameout, c_int nameout_sz) callconv(.C) bool;

/// GetMixerScroll
/// Get the leftmost track visible in the mixer
GetMixerScroll: *fn () callconv(.C) *MediaTrack;

/// GetMouseModifier
/// Get the current mouse modifier assignment for a specific modifier key assignment, in a specific context.
/// action will be filled in with the command ID number for a built-in mouse modifier
/// or built-in REAPER command ID, or the custom action ID string.
/// Note: the action string may have a space and 'c' or 'm' appended to it to specify command ID vs mouse modifier ID.
/// See SetMouseModifier for more information.
/// 
GetMouseModifier: *fn (const *c_char context, c_int modifier_flag, *c_char actionOut, c_int actionOut_sz) callconv(.C) void;

/// GetMousePosition
/// get mouse position in screen coordinates
GetMousePosition: *fn (*c_int xOut, *c_int yOut) callconv(.C) void;

/// GetNumAudioInputs
/// Return number of normal audio hardware inputs available
GetNumAudioInputs: *fn () callconv(.C) c_int;

/// GetNumAudioOutputs
/// Return number of normal audio hardware outputs available
GetNumAudioOutputs: *fn () callconv(.C) c_int;

/// GetNumMIDIInputs
/// returns max number of real midi hardware inputs
GetNumMIDIInputs: *fn () callconv(.C) c_int;

/// GetNumMIDIOutputs
/// returns max number of real midi hardware outputs
GetNumMIDIOutputs: *fn () callconv(.C) c_int;

/// GetNumTakeMarkers
/// Returns number of take markers. See GetTakeMarker, SetTakeMarker, DeleteTakeMarker
GetNumTakeMarkers: *fn (*MediaItem_Take take) callconv(.C) c_int;

/// GetNumTracks
GetNumTracks: *fn () callconv(.C) c_int;

/// GetOS
/// Returns "Win32", "Win64", "OSX32", "OSX64", "macOS-arm64", or "Other".
GetOS: *fn () callconv(.C) const *c_char ; //TODO check me

/// GetOutputChannelName
GetOutputChannelName: *fn (c_int channelIndex) callconv(.C) const *c_char ; //TODO check me

/// GetOutputLatency
/// returns output latency in seconds
GetOutputLatency: *fn () callconv(.C) double;

/// GetParentTrack
GetParentTrack: *fn (*MediaTrack track) callconv(.C) *MediaTrack;

/// GetPeakFileName
/// get the peak file name for a given file (can be either filename.reapeaks,or a hashed filename in another path)
GetPeakFileName: *fn (const *c_char fn, *c_char bufOut, c_int bufOut_sz) callconv(.C) void;

/// GetPeakFileNameEx
/// get the peak file name for a given file (can be either filename.reapeaks,or a hashed filename in another path)
GetPeakFileNameEx: *fn (const *c_char fn, *c_char buf, c_int buf_sz, bool forWrite) callconv(.C) void;

/// GetPeakFileNameEx2
/// Like GetPeakFileNameEx, but you can specify peaksfileextension such as ".reapeaks"
GetPeakFileNameEx2: *fn (const *c_char fn, *c_char buf, c_int buf_sz, bool forWrite, const *c_char peaksfileextension) callconv(.C) void;

/// GetPeaksBitmap
/// see note in reaper_plugin.h about PCM_source_peaktransfer_t::samplerate
GetPeaksBitmap: *fn (*PCM_source_peaktransfer_t pks, double maxamp, c_int w, c_int h, *LICE_IBitmap bmp) callconv(.C) *void;

/// GetPlayPosition
/// returns latency-compensated actual-what-you-hear position
GetPlayPosition: *fn () callconv(.C) double;

/// GetPlayPosition2
/// returns position of next audio block being processed
GetPlayPosition2: *fn () callconv(.C) double;

/// GetPlayPosition2Ex
/// returns position of next audio block being processed
GetPlayPosition2Ex: *fn (*ReaProject proj) callconv(.C) double;

/// GetPlayPositionEx
/// returns latency-compensated actual-what-you-hear position
GetPlayPositionEx: *fn (*ReaProject proj) callconv(.C) double;

/// GetPlayState
/// &1=playing, &2=paused, &4=is recording
GetPlayState: *fn () callconv(.C) c_int;

/// GetPlayStateEx
/// &1=playing, &2=paused, &4=is recording
GetPlayStateEx: *fn (*ReaProject proj) callconv(.C) c_int;

/// GetPreferredDiskReadMode
/// Gets user configured preferred disk read mode. mode/nb/bs are all parameters that should be passed to WDL_FileRead, see for more information.
GetPreferredDiskReadMode: *fn (*c_int mode, *c_int nb, *c_int bs) callconv(.C) void;

/// GetPreferredDiskReadModePeak
/// Gets user configured preferred disk read mode for use when building peaks. mode/nb/bs are all parameters that should be passed to WDL_FileRead, see for more information.
GetPreferredDiskReadModePeak: *fn (*c_int mode, *c_int nb, *c_int bs) callconv(.C) void;

/// GetPreferredDiskWriteMode
/// Gets user configured preferred disk write mode. nb will receive two values, the initial and maximum write buffer counts. mode/nb/bs are all parameters that should be passed to WDL_FileWrite, see for more information. 
GetPreferredDiskWriteMode: *fn (*c_int mode, *c_int nb, *c_int bs) callconv(.C) void;

/// GetProjectLength
/// returns length of project (maximum of end of media item, markers, end of regions, tempo map
GetProjectLength: *fn (*ReaProject proj) callconv(.C) double;

/// GetProjectName
GetProjectName: *fn (*ReaProject proj, *c_char bufOut, c_int bufOut_sz) callconv(.C) void;

/// GetProjectPath
/// Get the project recording path.
GetProjectPath: *fn (*c_char bufOut, c_int bufOut_sz) callconv(.C) void;

/// GetProjectPathEx
/// Get the project recording path.
GetProjectPathEx: *fn (*ReaProject proj, *c_char bufOut, c_int bufOut_sz) callconv(.C) void;

/// GetProjectStateChangeCount
/// returns an integer that changes when the project state changes
GetProjectStateChangeCount: *fn (*ReaProject proj) callconv(.C) c_int;

/// GetProjectTimeOffset
/// Gets project time offset in seconds (project settings - project start time). If rndframe is true, the offset is rounded to a multiple of the project frame size.
GetProjectTimeOffset: *fn (*ReaProject proj, bool rndframe) callconv(.C) double;

/// GetProjectTimeSignature
/// deprecated
GetProjectTimeSignature: *fn (*double bpmOut, *double bpiOut) callconv(.C) void;

/// GetProjectTimeSignature2
/// Gets basic time signature (beats per minute, numerator of time signature in bpi)
/// this does not reflect tempo envelopes but is purely what is set in the project settings.
GetProjectTimeSignature2: *fn (*ReaProject proj, *double bpmOut, *double bpiOut) callconv(.C) void;

/// GetProjExtState
/// Get the value previously associated with this extname and key, the last time the project was saved. See SetProjExtState, EnumProjExtState.
GetProjExtState: *fn (*ReaProject proj, const *c_char extname, const *c_char key, *c_char valOutNeedBig, c_int valOutNeedBig_sz) callconv(.C) c_int;

/// GetResourcePath
/// returns path where ini files are stored, other things are in subdirectories.
GetResourcePath: *fn () callconv(.C) const *c_char ; //TODO check me

/// GetSelectedEnvelope
/// get the currently selected envelope, returns NULL/nil if no envelope is selected
GetSelectedEnvelope: *fn (*ReaProject proj) callconv(.C) *TrackEnvelope;

/// GetSelectedMediaItem
/// get a selected item by selected item count (zero-based) (proj=0 for active project)
GetSelectedMediaItem: *fn (*ReaProject proj, c_int selitem) callconv(.C) *MediaItem;

/// GetSelectedTrack
/// Get a selected track from a project (proj=0 for active project) by selected track count (zero-based). This function ignores the master track, see GetSelectedTrack2.
GetSelectedTrack: *fn (*ReaProject proj, c_int seltrackidx) callconv(.C) *MediaTrack;

/// GetSelectedTrack2
/// Get a selected track from a project (proj=0 for active project) by selected track count (zero-based).
GetSelectedTrack2: *fn (*ReaProject proj, c_int seltrackidx, bool wantmaster) callconv(.C) *MediaTrack;

/// GetSelectedTrackEnvelope
/// get the currently selected track envelope, returns NULL/nil if no envelope is selected
GetSelectedTrackEnvelope: *fn (*ReaProject proj) callconv(.C) *TrackEnvelope;

/// GetSet_ArrangeView2
/// Gets or sets the arrange view start/end time for screen coordinates. use screen_x_start=screen_x_end=0 to use the full arrange view's start/end time
GetSet_ArrangeView2: *fn (*ReaProject proj, bool isSet, c_int screen_x_start, c_int screen_x_end, *double start_timeInOut, *double end_timeInOut) callconv(.C) void;

/// GetSet_LoopTimeRange
GetSet_LoopTimeRange: *fn (bool isSet, bool isLoop, *double startOut, *double endOut, bool allowautoseek) callconv(.C) void;

/// GetSet_LoopTimeRange2
GetSet_LoopTimeRange2: *fn (*ReaProject proj, bool isSet, bool isLoop, *double startOut, *double endOut, bool allowautoseek) callconv(.C) void;

/// GetSetAutomationItemInfo
/// Get or set automation item information. autoitem_idx=0 for the first automation item on an envelope, 1 for the second item, etc. desc can be any of the following:
/// D_POOL_ID : double * : automation item pool ID (as an integer); edits are propagated to all other automation items that share a pool ID
/// D_POSITION : double * : automation item timeline position in seconds
/// D_LENGTH : double * : automation item length in seconds
/// D_STARTOFFS : double * : automation item start offset in seconds
/// D_PLAYRATE : double * : automation item playback rate
/// D_BASELINE : double * : automation item baseline value in the range [0,1]
/// D_AMPLITUDE : double * : automation item amplitude in the range [-1,1]
/// D_LOOPSRC : double * : nonzero if the automation item contents are looped
/// D_UISEL : double * : nonzero if the automation item is selected in the arrange view
/// D_POOL_QNLEN : double * : automation item pooled source length in quarter notes (setting will affect all pooled instances)
/// 
GetSetAutomationItemInfo: *fn (*TrackEnvelope env, c_int autoitem_idx, const *c_char desc, double value, bool is_set) callconv(.C) double;

/// GetSetAutomationItemInfo_String
/// Get or set automation item information. autoitem_idx=0 for the first automation item on an envelope, 1 for the second item, etc. returns true on success. desc can be any of the following:
/// P_POOL_NAME : c_char * : name of the underlying automation item pool
/// P_POOL_EXT:xyz : c_char * : extension-specific persistent data
/// 
GetSetAutomationItemInfo_String: *fn (*TrackEnvelope env, c_int autoitem_idx, const *c_char desc, *c_char valuestrNeedBig, bool is_set) callconv(.C) bool;

/// GetSetEnvelopeInfo_String
/// Gets/sets an attribute string:
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// GUID : GUID * : 16-byte GUID, can query only, not set. If using a _String() function, GUID is a string {xyz-...}.
/// 
GetSetEnvelopeInfo_String: *fn (*TrackEnvelope env, const *c_char parmname, *c_char stringNeedBig, bool setNewValue) callconv(.C) bool;

/// GetSetEnvelopeState
/// deprecated -- see SetEnvelopeStateChunk, GetEnvelopeStateChunk
GetSetEnvelopeState: *fn (*TrackEnvelope env, *c_char str, c_int str_sz) callconv(.C) bool;

/// GetSetEnvelopeState2
/// deprecated -- see SetEnvelopeStateChunk, GetEnvelopeStateChunk
GetSetEnvelopeState2: *fn (*TrackEnvelope env, *c_char str, c_int str_sz, bool isundo) callconv(.C) bool;

/// GetSetItemState
/// deprecated -- see SetItemStateChunk, GetItemStateChunk
GetSetItemState: *fn (*MediaItem item, *c_char str, c_int str_sz) callconv(.C) bool;

/// GetSetItemState2
/// deprecated -- see SetItemStateChunk, GetItemStateChunk
GetSetItemState2: *fn (*MediaItem item, *c_char str, c_int str_sz, bool isundo) callconv(.C) bool;

/// GetSetMediaItemInfo
/// P_TRACK : MediaTrack * : (read-only)
/// B_MUTE : bool * : muted (item solo overrides). setting this value will clear C_MUTE_SOLO.
/// B_MUTE_ACTUAL : bool * : muted (ignores solo). setting this value will not affect C_MUTE_SOLO.
/// C_LANEPLAYS : c_char * : in fixed lane tracks, 0=this item lane does not play, 1=this item lane plays exclusively, 2=this item lane plays and other lanes also play, -1=this item is on a non-visible, non-playing lane on a non-fixed-lane track (read-only)
/// C_MUTE_SOLO : c_char * : solo override (-1=soloed, 0=no override, 1=unsoloed). note that this API does not automatically unsolo other items when soloing (nor clear the unsolos when clearing the last soloed item), it must be done by the caller via action or via this API.
/// B_LOOPSRC : bool * : loop source
/// B_ALLTAKESPLAY : bool * : all takes play
/// B_UISEL : bool * : selected in arrange view
/// C_BEATATTACHMODE : c_char * : item timebase, -1=track or project default, 1=beats (position, length, rate), 2=beats (position only). for auto-stretch timebase: C_BEATATTACHMODE=1, C_AUTOSTRETCH=1
/// C_AUTOSTRETCH: : c_char * : auto-stretch at project tempo changes, 1=enabled, requires C_BEATATTACHMODE=1
/// C_LOCK : c_char * : locked, &1=locked
/// D_VOL : double * : item volume,  0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
/// D_POSITION : double * : item position in seconds
/// D_LENGTH : double * : item length in seconds
/// D_SNAPOFFSET : double * : item snap offset in seconds
/// D_FADEINLEN : double * : item manual fadein length in seconds
/// D_FADEOUTLEN : double * : item manual fadeout length in seconds
/// D_FADEINDIR : double * : item fadein curvature, -1..1
/// D_FADEOUTDIR : double * : item fadeout curvature, -1..1
/// D_FADEINLEN_AUTO : double * : item auto-fadein length in seconds, -1=no auto-fadein
/// D_FADEOUTLEN_AUTO : double * : item auto-fadeout length in seconds, -1=no auto-fadeout
/// C_FADEINSHAPE : c_int * : fadein shape, 0..6, 0=linear
/// C_FADEOUTSHAPE : c_int * : fadeout shape, 0..6, 0=linear
/// I_GROUPID : c_int * : group ID, 0=no group
/// I_LASTY : c_int * : Y-position (relative to top of track) in pixels (read-only)
/// I_LASTH : c_int * : height in pixels (read-only)
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// I_CURTAKE : c_int * : active take number
/// IP_ITEMNUMBER : c_int : item number on this track (read-only, returns the item number directly)
/// F_FREEMODE_Y : float * : free item positioning or fixed lane Y-position. 0=top of track, 1.0=bottom of track
/// F_FREEMODE_H : float * : free item positioning or fixed lane height. 0.5=half the track height, 1.0=full track height
/// I_FIXEDLANE : c_int * : fixed lane of item (fine to call with setNewValue, but returned value is read-only)
/// B_FIXEDLANE_HIDDEN : bool * : true if displaying only one fixed lane and this item is in a different lane (read-only)
/// P_NOTES : c_char * : item note text (do not write to returned pointer, use setNewValue to update)
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
/// 
GetSetMediaItemInfo: *fn (*MediaItem item, const *c_char parmname, *void setNewValue) callconv(.C) *void;

/// GetSetMediaItemInfo_String
/// Gets/sets an item attribute string:
/// P_NOTES : c_char * : item note text (do not write to returned pointer, use setNewValue to update)
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
/// 
GetSetMediaItemInfo_String: *fn (*MediaItem item, const *c_char parmname, *c_char stringNeedBig, bool setNewValue) callconv(.C) bool;

/// GetSetMediaItemTakeInfo
/// P_TRACK : pointer to MediaTrack (read-only)
/// P_ITEM : pointer to MediaItem (read-only)
/// P_SOURCE : PCM_source *. Note that if setting this, you should first retrieve the old source, set the new, THEN delete the old.
/// P_NAME : c_char * : take name
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
/// D_STARTOFFS : double * : start offset in source media, in seconds
/// D_VOL : double * : take volume, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc, negative if take polarity is flipped
/// D_PAN : double * : take pan, -1..1
/// D_PANLAW : double * : take pan law, -1=default, 0.5=-6dB, 1.0=+0dB, etc
/// D_PLAYRATE : double * : take playback rate, 0.5=half speed, 1=normal, 2=double speed, etc
/// D_PITCH : double * : take pitch adjustment in semitones, -12=one octave down, 0=normal, +12=one octave up, etc
/// B_PPITCH : bool * : preserve pitch when changing playback rate
/// I_LASTY : c_int * : Y-position (relative to top of track) in pixels (read-only)
/// I_LASTH : c_int * : height in pixels (read-only)
/// I_CHANMODE : c_int * : channel mode, 0=normal, 1=reverse stereo, 2=downmix, 3=left, 4=right
/// I_PITCHMODE : c_int * : pitch shifter mode, -1=project default, otherwise high 2 bytes=shifter, low 2 bytes=parameter
/// I_STRETCHFLAGS : c_int * : stretch marker flags (&7 mask for mode override: 0=default, 1=balanced, 2/3/6=tonal, 4=transient, 5=no pre-echo)
/// F_STRETCHFADESIZE : float * : stretch marker fade size in seconds (0.0025 default)
/// I_RECPASSID : c_int * : record pass ID
/// I_TAKEFX_NCH : c_int * : number of internal audio channels for per-take FX to use (OK to call with setNewValue, but the returned value is read-only)
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// IP_TAKENUMBER : c_int : take number (read-only, returns the take number directly)
/// 
GetSetMediaItemTakeInfo: *fn (*MediaItem_Take tk, const *c_char parmname, *void setNewValue) callconv(.C) *void;

/// GetSetMediaItemTakeInfo_String
/// Gets/sets a take attribute string:
/// P_NAME : c_char * : take name
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
/// 
GetSetMediaItemTakeInfo_String: *fn (*MediaItem_Take tk, const *c_char parmname, *c_char stringNeedBig, bool setNewValue) callconv(.C) bool;

/// GetSetMediaTrackInfo
/// Get or set track attributes.
/// P_PARTRACK : MediaTrack * : parent track (read-only)
/// P_PROJECT : ReaProject * : parent project (read-only)
/// P_NAME : c_char * : track name (on master returns NULL)
/// P_ICON : const c_char * : track icon (full filename, or relative to resource_path/data/track_icons)
/// P_LANENAME:n : c_char * : lane name (returns NULL for non-fixed-lane-tracks)
/// P_MCP_LAYOUT : const c_char * : layout name
/// P_RAZOREDITS : const c_char * : list of razor edit areas, as space-separated triples of start time, end time, and envelope GUID string.
///   Example: "0.0 1.0 \"\" 0.0 1.0 "{xyz-...}"
/// P_RAZOREDITS_EXT : const c_char * : list of razor edit areas, as comma-separated sets of space-separated tuples of start time, end time, optional: envelope GUID string, fixed/fipm top y-position, fixed/fipm bottom y-position.
///   Example: "0.0 1.0,0.0 1.0 "{xyz-...}",1.0 2.0 "" 0.25 0.75"
/// P_TCP_LAYOUT : const c_char * : layout name
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// P_UI_RECT:tcp.mute : c_char * : read-only, allows querying screen position + size of track WALTER elements (tcp.size queries screen position and size of entire TCP, etc).
/// GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
/// B_MUTE : bool * : muted
/// B_PHASE : bool * : track phase inverted
/// B_RECMON_IN_EFFECT : bool * : record monitoring in effect (current audio-thread playback state, read-only)
/// IP_TRACKNUMBER : c_int : track number 1-based, 0=not found, -1=master track (read-only, returns the c_int directly)
/// I_SOLO : c_int * : soloed, 0=not soloed, 1=soloed, 2=soloed in place, 5=safe soloed, 6=safe soloed in place
/// B_SOLO_DEFEAT : bool * : when set, if anything else is soloed and this track is not muted, this track acts soloed
/// I_FXEN : c_int * : fx enabled, 0=bypassed, !0=fx active
/// I_RECARM : c_int * : record armed, 0=not record armed, 1=record armed
/// I_RECINPUT : c_int * : record input, <0=no input. if 4096 set, input is MIDI and low 5 bits represent channel (0=all, 1-16=only chan), next 6 bits represent physical input (63=all, 62=VKB). If 4096 is not set, low 10 bits (0..1023) are input start channel (ReaRoute/Loopback start at 512). If 2048 is set, input is multichannel input (using track channel count), or if 1024 is set, input is stereo input, otherwise input is mono.
/// I_RECMODE : c_int * : record mode, 0=input, 1=stereo out, 2=none, 3=stereo out w/latency compensation, 4=midi output, 5=mono out, 6=mono out w/ latency compensation, 7=midi overdub, 8=midi replace
/// I_RECMODE_FLAGS : c_int * : record mode flags, &3=output recording mode (0=post fader, 1=pre-fx, 2=post-fx/pre-fader)
/// I_RECMON : c_int * : record monitoring, 0=off, 1=normal, 2=not when playing (tape style)
/// I_RECMONITEMS : c_int * : monitor items while recording, 0=off, 1=on
/// B_AUTO_RECARM : bool * : automatically set record arm when selected (does not immediately affect recarm state, script should set directly if desired)
/// I_VUMODE : c_int * : track vu mode, &1:disabled, &30==0:stereo peaks, &30==2:multichannel peaks, &30==4:stereo RMS, &30==8:combined RMS, &30==12:LUFS-M, &30==16:LUFS-S (readout=max), &30==20:LUFS-S (readout=current), &32:LUFS calculation on channels 1+2 only
/// I_AUTOMODE : c_int * : track automation mode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch
/// I_NCHAN : c_int * : number of track channels, 2-128, even numbers only
/// I_SELECTED : c_int * : track selected, 0=unselected, 1=selected
/// I_WNDH : c_int * : current TCP window height in pixels including envelopes (read-only)
/// I_TCPH : c_int * : current TCP window height in pixels not including envelopes (read-only)
/// I_TCPY : c_int * : current TCP window Y-position in pixels relative to top of arrange view (read-only)
/// I_MCPX : c_int * : current MCP X-position in pixels relative to mixer container (read-only)
/// I_MCPY : c_int * : current MCP Y-position in pixels relative to mixer container (read-only)
/// I_MCPW : c_int * : current MCP width in pixels (read-only)
/// I_MCPH : c_int * : current MCP height in pixels (read-only)
/// I_FOLDERDEPTH : c_int * : folder depth change, 0=normal, 1=track is a folder parent, -1=track is the last in the innermost folder, -2=track is the last in the innermost and next-innermost folders, etc
/// I_FOLDERCOMPACT : c_int * : folder collapsed state (only valid on folders), 0=normal, 1=collapsed, 2=fully collapsed
/// I_MIDIHWOUT : c_int * : track midi hardware output index, <0=disabled, low 5 bits are which channels (0=all, 1-16), next 5 bits are output device index (0-31)
/// I_MIDI_INPUT_CHANMAP : c_int * : -1 maps to source channel, otherwise 1-16 to map to MIDI channel
/// I_MIDI_CTL_CHAN : c_int * : -1 no link, 0-15 link to MIDI volume/pan on channel, 16 link to MIDI volume/pan on all channels
/// I_MIDI_TRACKSEL_FLAG : c_int * : MIDI editor track list options: &1=expand media items, &2=exclude from list, &4=auto-pruned
/// I_PERFFLAGS : c_int * : track performance flags, &1=no media buffering, &2=no anticipative FX
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// I_HEIGHTOVERRIDE : c_int * : custom height override for TCP window, 0 for none, otherwise size in pixels
/// I_SPACER : c_int * : 1=TCP track spacer above this trackB_HEIGHTLOCK : bool * : track height lock (must set I_HEIGHTOVERRIDE before locking)
/// D_VOL : double * : trim volume of track, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
/// D_PAN : double * : trim pan of track, -1..1
/// D_WIDTH : double * : width of track, -1..1
/// D_DUALPANL : double * : dualpan position 1, -1..1, only if I_PANMODE==6
/// D_DUALPANR : double * : dualpan position 2, -1..1, only if I_PANMODE==6
/// I_PANMODE : c_int * : pan mode, 0=classic 3.x, 3=new balance, 5=stereo pan, 6=dual pan
/// D_PANLAW : double * : pan law of track, <0=project default, 0.5=-6dB, 0.707..=-3dB, 1=+0dB, 1.414..=-3dB with gain compensation, 2=-6dB with gain compensation, etc
/// I_PANLAW_FLAGS : c_int * : pan law flags, 0=sine taper, 1=hybrid taper with deprecated behavior when gain compensation enabled, 2=linear taper, 3=hybrid taper
/// P_ENV:<envchunkname or P_ENV:{GUID... : TrackEnvelope * : (read-only) chunkname can be <VOLENV, <PANENV, etc; GUID is the stringified envelope GUID.
/// B_SHOWINMIXER : bool * : track control panel visible in mixer (do not use on master track)
/// B_SHOWINTCP : bool * : track control panel visible in arrange view (do not use on master track)
/// B_MAINSEND : bool * : track sends audio to parent
/// C_MAINSEND_OFFS : c_char * : channel offset of track send to parent
/// C_MAINSEND_NCH : c_char * : channel count of track send to parent (0=use all child track channels, 1=use one channel only)
/// I_FREEMODE : c_int * : 1=track free item positioning enabled, 2=track fixed lanes enabled (call UpdateTimeline() after changing)
/// I_NUMFIXEDLANES : c_int * : number of track fixed lanes (fine to call with setNewValue, but returned value is read-only)
/// C_LANESCOLLAPSED : c_char * : fixed lane collapse state (1=lanes collapsed, 2=track displays as non-fixed-lanes but hidden lanes exist)
/// C_LANESETTINGS : c_char * : fixed lane settings (&1=auto-remove empty lanes at bottom, &2=do not auto-comp new recording, &4=newly recorded lanes play exclusively (else add lanes in layers), &8=big lanes (else small lanes), &16=add new recording at bottom (else record into first available lane), &32=hide lane buttons
/// C_LANEPLAYS:N : c_char * :  on fixed lane tracks, 0=lane N does not play, 1=lane N plays exclusively, 2=lane N plays and other lanes also play (fine to call with setNewValue, but returned value is read-only)
/// C_ALLLANESPLAY : c_char * : on fixed lane tracks, 0=no lanes play, 1=all lanes play, 2=some lanes play (fine to call with setNewValue 0 or 1, but returned value is read-only)
/// C_BEATATTACHMODE : c_char * : track timebase, -1=project default, 0=time, 1=beats (position, length, rate), 2=beats (position only)
/// F_MCP_FXSEND_SCALE : float * : scale of fx+send area in MCP (0=minimum allowed, 1=maximum allowed)
/// F_MCP_FXPARM_SCALE : float * : scale of fx parameter area in MCP (0=minimum allowed, 1=maximum allowed)
/// F_MCP_SENDRGN_SCALE : float * : scale of send area as proportion of the fx+send total area (0=minimum allowed, 1=maximum allowed)
/// F_TCP_FXPARM_SCALE : float * : scale of TCP parameter area when TCP FX are embedded (0=min allowed, default, 1=max allowed)
/// I_PLAY_OFFSET_FLAG : c_int * : track media playback offset state, &1=bypassed, &2=offset value is measured in samples (otherwise measured in seconds)
/// D_PLAY_OFFSET : double * : track media playback offset, units depend on I_PLAY_OFFSET_FLAG
/// 
GetSetMediaTrackInfo: *fn (*MediaTrack tr, const *c_char parmname, *void setNewValue) callconv(.C) *void;

/// GetSetMediaTrackInfo_String
/// Get or set track string attributes.
/// P_NAME : c_char * : track name (on master returns NULL)
/// P_ICON : const c_char * : track icon (full filename, or relative to resource_path/data/track_icons)
/// P_LANENAME:n : c_char * : lane name (returns NULL for non-fixed-lane-tracks)
/// P_MCP_LAYOUT : const c_char * : layout name
/// P_RAZOREDITS : const c_char * : list of razor edit areas, as space-separated triples of start time, end time, and envelope GUID string.
///   Example: "0.0 1.0 \"\" 0.0 1.0 "{xyz-...}"
/// P_RAZOREDITS_EXT : const c_char * : list of razor edit areas, as comma-separated sets of space-separated tuples of start time, end time, optional: envelope GUID string, fixed/fipm top y-position, fixed/fipm bottom y-position.
///   Example: "0.0 1.0,0.0 1.0 "{xyz-...}",1.0 2.0 "" 0.25 0.75"
/// P_TCP_LAYOUT : const c_char * : layout name
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// P_UI_RECT:tcp.mute : c_char * : read-only, allows querying screen position + size of track WALTER elements (tcp.size queries screen position and size of entire TCP, etc).
/// GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
/// 
GetSetMediaTrackInfo_String: *fn (*MediaTrack tr, const *c_char parmname, *c_char stringNeedBig, bool setNewValue) callconv(.C) bool;

/// GetSetObjectState
/// get or set the state of a {track,item,envelope} as an RPPXML chunk
/// str="" to get the chunk string returned (must call FreeHeapPtr when done)
/// supply str to set the state (returns zero)
GetSetObjectState: *fn (*void obj, const *c_char str) callconv(.C) *c_char;

/// GetSetObjectState2
/// get or set the state of a {track,item,envelope} as an RPPXML chunk
/// str="" to get the chunk string returned (must call FreeHeapPtr when done)
/// supply str to set the state (returns zero)
/// set isundo if the state will be used for undo purposes (which may allow REAPER to get the state more efficiently
GetSetObjectState2: *fn (*void obj, const *c_char str, bool isundo) callconv(.C) *c_char;

/// GetSetProjectAuthor
/// deprecated, see GetSetProjectInfo_String with desc="PROJECT_AUTHOR"
GetSetProjectAuthor: *fn (*ReaProject proj, bool set, *c_char author, c_int author_sz) callconv(.C) void;

/// GetSetProjectGrid
/// Get or set the arrange view grid division. 0.25=quarter note, 1.0/3.0=half note triplet, etc. swingmode can be 1 for swing enabled, swingamt is -1..1. swingmode can be 3 for measure-grid. Returns grid configuration flags
GetSetProjectGrid: *fn (*ReaProject project, bool set, *double divisionInOutOptional, *c_int swingmodeInOutOptional, *double swingamtInOutOptional) callconv(.C) c_int;

/// GetSetProjectInfo
/// Get or set project information.
/// RENDER_SETTINGS : &(1|2)=0:master mix, &1=stems+master mix, &2=stems only, &4=multichannel tracks to multichannel files, &8=use render matrix, &16=tracks with only mono media to mono files, &32=selected media items, &64=selected media items via master, &128=selected tracks via master, &256=embed transients if format supports, &512=embed metadata if format supports, &1024=embed take markers if format supports, &2048=2nd pass render
/// RENDER_BOUNDSFLAG : 0=custom time bounds, 1=entire project, 2=time selection, 3=all project regions, 4=selected media items, 5=selected project regions, 6=all project markers, 7=selected project markers
/// RENDER_CHANNELS : number of channels in rendered file
/// RENDER_SRATE : sample rate of rendered file (or 0 for project sample rate)
/// RENDER_STARTPOS : render start time when RENDER_BOUNDSFLAG=0
/// RENDER_ENDPOS : render end time when RENDER_BOUNDSFLAG=0
/// RENDER_TAILFLAG : apply render tail setting when rendering: &1=custom time bounds, &2=entire project, &4=time selection, &8=all project markers/regions, &16=selected media items, &32=selected project markers/regions
/// RENDER_TAILMS : tail length in ms to render (only used if RENDER_BOUNDSFLAG and RENDER_TAILFLAG are set)
/// RENDER_ADDTOPROJ : &1=add rendered files to project, &2=do not render files that are likely silent
/// RENDER_DITHER : &1=dither, &2=noise shaping, &4=dither stems, &8=noise shaping on stems
/// RENDER_NORMALIZE: &1=enable, (&14==0)=LUFS-I, (&14==2)=RMS, (&14==4)=peak, (&14==6)=true peak, (&14==8)=LUFS-M max, (&14==10)=LUFS-S max, &32=normalize stems to common gain based on master, &64=enable brickwall limit, &128=brickwall limit true peak, (&2304==256)=only normalize files that are too loud, (&2304==2048)=only normalize files that are too quiet, &512=apply fade-in, &1024=apply fade-out
/// RENDER_NORMALIZE_TARGET: render normalization target as amplitude, so 0.5 means -6.02dB, 0.25 means -12.04dB, etc
/// RENDER_BRICKWALL: render brickwall limit as amplitude, so 0.5 means -6.02dB, 0.25 means -12.04dB, etc
/// RENDER_FADEIN: render fade-in (0.001 means 1 ms, requires RENDER_NORMALIZE&512)
/// RENDER_FADEOUT: render fade-out (0.001 means 1 ms, requires RENDER_NORMALIZE&1024)
/// RENDER_FADEINSHAPE: render fade-in shape
/// RENDER_FADEOUTSHAPE: render fade-out shape
/// PROJECT_SRATE : samplerate (ignored unless PROJECT_SRATE_USE set)
/// PROJECT_SRATE_USE : set to 1 if project samplerate is used
/// 
GetSetProjectInfo: *fn (*ReaProject project, const *c_char desc, double value, bool is_set) callconv(.C) double;

/// GetSetProjectInfo_String
/// Get or set project information.
/// PROJECT_NAME : project file name (read-only, is_set will be ignored)
/// PROJECT_TITLE : title field from Project Settings/Notes dialog
/// PROJECT_AUTHOR : author field from Project Settings/Notes dialog
/// TRACK_GROUP_NAME:X : track group name, X should be 1..64
/// MARKER_GUID:X : get the GUID (unique ID) of the marker or region with index X, where X is the index passed to EnumProjectMarkers, not necessarily the displayed number (read-only)
/// MARKER_INDEX_FROM_GUID:{GUID} : get the GUID index of the marker or region with GUID {GUID} (read-only)
/// OPENCOPY_CFGIDX : integer for the configuration of format to use when creating copies/applying FX. 0=wave (auto-depth), 1=APPLYFX_FORMAT, 2=RECORD_FORMAT
/// RECORD_PATH : recording directory -- may be blank or a relative path, to get the effective path see GetProjectPathEx()
/// RECORD_PATH_SECONDARY : secondary recording directory
/// RECORD_FORMAT : base64-encoded sink configuration (see project files, etc). Callers can also pass a simple 4-byte string (non-base64-encoded), e.g. "evaw" or "l3pm", to use default settings for that sink type.
/// APPLYFX_FORMAT : base64-encoded sink configuration (see project files, etc). Used only if RECFMT_OPENCOPY is set to 1. Callers can also pass a simple 4-byte string (non-base64-encoded), e.g. "evaw" or "l3pm", to use default settings for that sink type.
/// RENDER_FILE : render directory
/// RENDER_PATTERN : render file name (may contain wildcards)
/// RENDER_METADATA : get or set the metadata saved with the project (not metadata embedded in project media). Example, ID3 album name metadata: valuestr="ID3:TALB" to get, valuestr="ID3:TALB|my album name" to set. Call with valuestr="" and is_set=false to get a semicolon-separated list of defined project metadata identifiers.
/// RENDER_TARGETS : semicolon separated list of files that would be written if the project is rendered using the most recent render settings
/// RENDER_STATS : (read-only) semicolon separated list of statistics for the most recently rendered files. call with valuestr="XXX" to run an action (for example, "42437"=dry run render selected items) before returning statistics.
/// RENDER_FORMAT : base64-encoded sink configuration (see project files, etc). Callers can also pass a simple 4-byte string (non-base64-encoded), e.g. "evaw" or "l3pm", to use default settings for that sink type.
/// RENDER_FORMAT2 : base64-encoded secondary sink configuration. Callers can also pass a simple 4-byte string (non-base64-encoded), e.g. "evaw" or "l3pm", to use default settings for that sink type, or "" to disable secondary render.
/// 
GetSetProjectInfo_String: *fn (*ReaProject project, const *c_char desc, *c_char valuestrNeedBig, bool is_set) callconv(.C) bool;

/// GetSetProjectNotes
/// gets or sets project notes, notesNeedBig_sz is ignored when setting
GetSetProjectNotes: *fn (*ReaProject proj, bool set, *c_char notesNeedBig, c_int notesNeedBig_sz) callconv(.C) void;

/// GetSetRepeat
/// -1 == query,0=clear,1=set,>1=toggle . returns new value
GetSetRepeat: *fn (c_int val) callconv(.C) c_int;

/// GetSetRepeatEx
/// -1 == query,0=clear,1=set,>1=toggle . returns new value
GetSetRepeatEx: *fn (*ReaProject proj, c_int val) callconv(.C) c_int;

/// GetSetTrackGroupMembership
/// Gets or modifies the group membership for a track. Returns group state prior to call (each bit represents one of the 32 group numbers). if setmask has bits set, those bits in setvalue will be applied to group. Group can be one of:
/// MEDIA_EDIT_LEAD
/// MEDIA_EDIT_FOLLOW
/// VOLUME_LEAD
/// VOLUME_FOLLOW
/// VOLUME_VCA_LEAD
/// VOLUME_VCA_FOLLOW
/// PAN_LEAD
/// PAN_FOLLOW
/// WIDTH_LEAD
/// WIDTH_FOLLOW
/// MUTE_LEAD
/// MUTE_FOLLOW
/// SOLO_LEAD
/// SOLO_FOLLOW
/// RECARM_LEAD
/// RECARM_FOLLOW
/// POLARITY_LEAD
/// POLARITY_FOLLOW
/// AUTOMODE_LEAD
/// AUTOMODE_FOLLOW
/// VOLUME_REVERSE
/// PAN_REVERSE
/// WIDTH_REVERSE
/// NO_LEAD_WHEN_FOLLOW
/// VOLUME_VCA_FOLLOW_ISPREFX
/// 
/// Note: REAPER v6.11 and earlier used _MASTER and _SLAVE rather than _LEAD and _FOLLOW, which is deprecated but still supported (scripts that must support v6.11 and earlier can use the deprecated strings).
/// 
c_int GetSetTrackGroupMembership: *fn (*MediaTrack tr, const *c_char groupname, unsigned c_int setmask, unsigned c_int setvalue) callconv(.C) unsigned;

/// GetSetTrackGroupMembershipHigh
/// Gets or modifies the group membership for a track. Returns group state prior to call (each bit represents one of the high 32 group numbers). if setmask has bits set, those bits in setvalue will be applied to group. Group can be one of:
/// MEDIA_EDIT_LEAD
/// MEDIA_EDIT_FOLLOW
/// VOLUME_LEAD
/// VOLUME_FOLLOW
/// VOLUME_VCA_LEAD
/// VOLUME_VCA_FOLLOW
/// PAN_LEAD
/// PAN_FOLLOW
/// WIDTH_LEAD
/// WIDTH_FOLLOW
/// MUTE_LEAD
/// MUTE_FOLLOW
/// SOLO_LEAD
/// SOLO_FOLLOW
/// RECARM_LEAD
/// RECARM_FOLLOW
/// POLARITY_LEAD
/// POLARITY_FOLLOW
/// AUTOMODE_LEAD
/// AUTOMODE_FOLLOW
/// VOLUME_REVERSE
/// PAN_REVERSE
/// WIDTH_REVERSE
/// NO_LEAD_WHEN_FOLLOW
/// VOLUME_VCA_FOLLOW_ISPREFX
/// 
/// Note: REAPER v6.11 and earlier used _MASTER and _SLAVE rather than _LEAD and _FOLLOW, which is deprecated but still supported (scripts that must support v6.11 and earlier can use the deprecated strings).
/// 
c_int GetSetTrackGroupMembershipHigh: *fn (*MediaTrack tr, const *c_char groupname, unsigned c_int setmask, unsigned c_int setvalue) callconv(.C) unsigned;

/// GetSetTrackMIDISupportFile
/// Get or set the filename for storage of various track MIDI c_characteristics. 0=MIDI colormap image file, 1 or 2=MIDI bank/program select file (2=set new default). If fn != NULL, a new track MIDI storage file will be set; otherwise the existing track MIDI storage file will be returned. 
GetSetTrackMIDISupportFile: *fn (*ReaProject proj, *MediaTrack track, c_int which, const *c_char filename) callconv(.C) const *c_char ; //TODO check me

/// GetSetTrackSendInfo
/// Get or set send/receive/hardware output attributes.
/// category is <0 for receives, 0=sends, >0 for hardware outputs
///  sendidx is 0..n (to enumerate, iterate over sendidx until it returns NULL)
/// parameter names:
/// P_DESTTRACK : MediaTrack * : destination track, only applies for sends/recvs (read-only)
/// P_SRCTRACK : MediaTrack * : source track, only applies for sends/recvs (read-only)
/// P_ENV:<envchunkname : TrackEnvelope * : call with :<VOLENV, :<PANENV, etc appended (read-only)
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// B_MUTE : bool *
/// B_PHASE : bool * : true to flip phase
/// B_MONO : bool *
/// D_VOL : double * : 1.0 = +0dB etc
/// D_PAN : double * : -1..+1
/// D_PANLAW : double * : 1.0=+0.0db, 0.5=-6dB, -1.0 = projdef etc
/// I_SENDMODE : c_int * : 0=post-fader, 1=pre-fx, 2=post-fx (deprecated), 3=post-fx
/// I_AUTOMODE : c_int * : automation mode (-1=use track automode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch)
/// I_SRCCHAN : c_int * : -1 for no audio send. Low 10 bits specify channel offset, and higher bits specify channel count. (srcchan>>10) == 0 for stereo, 1 for mono, 2 for 4 channel, 3 for 6 channel, etc.
/// I_DSTCHAN : c_int * : low 10 bits are destination index, &1024 set to mix to mono.
/// I_MIDIFLAGS : c_int * : low 5 bits=source channel 0=all, 1-16, 31=MIDI send disabled, next 5 bits=dest channel, 0=orig, 1-16=chan. &1024 for faders-send MIDI vol/pan. (>>14)&255 = src bus (0 for all, 1 for normal, 2+). (>>22)&255=destination bus (0 for all, 1 for normal, 2+)
/// See CreateTrackSend, RemoveTrackSend.
GetSetTrackSendInfo: *fn (*MediaTrack tr, c_int category, c_int sendidx, const *c_char parmname, *void setNewValue) callconv(.C) *void;

/// GetSetTrackSendInfo_String
/// Gets/sets a send attribute string:
/// P_EXT:xyz : c_char * : extension-specific persistent data
/// 
GetSetTrackSendInfo_String: *fn (*MediaTrack tr, c_int category, c_int sendidx, const *c_char parmname, *c_char stringNeedBig, bool setNewValue) callconv(.C) bool;

/// GetSetTrackState
/// deprecated -- see SetTrackStateChunk, GetTrackStateChunk
GetSetTrackState: *fn (*MediaTrack track, *c_char str, c_int str_sz) callconv(.C) bool;

/// GetSetTrackState2
/// deprecated -- see SetTrackStateChunk, GetTrackStateChunk
GetSetTrackState2: *fn (*MediaTrack track, *c_char str, c_int str_sz, bool isundo) callconv(.C) bool;

/// GetSubProjectFromSource
GetSubProjectFromSource: *fn (*PCM_source src) callconv(.C) *ReaProject;

/// GetTake
/// get a take from an item by take count (zero-based)
GetTake(*MediaItem item, c_int takeidx) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// GetTakeEnvelope
GetTakeEnvelope: *fn (*MediaItem_Take take, c_int envidx) callconv(.C) *TrackEnvelope;

/// GetTakeEnvelopeByName
GetTakeEnvelopeByName: *fn (*MediaItem_Take take, const *c_char envname) callconv(.C) *TrackEnvelope;

/// GetTakeMarker
/// Get information about a take marker. Returns the position in media item source time, or -1 if the take marker does not exist. See GetNumTakeMarkers, SetTakeMarker, DeleteTakeMarker
GetTakeMarker: *fn (*MediaItem_Take take, c_int idx, *c_char nameOut, c_int nameOut_sz, *c_int colorOutOptional) callconv(.C) double;

/// GetTakeName
/// returns NULL if the take is not valid
GetTakeName: *fn (*MediaItem_Take take) callconv(.C) const *c_char ; //TODO check me

/// GetTakeNumStretchMarkers
/// Returns number of stretch markers in take
GetTakeNumStretchMarkers: *fn (*MediaItem_Take take) callconv(.C) c_int;

/// GetTakeStretchMarker
/// Gets information on a stretch marker, idx is 0..n. Returns -1 if stretch marker not valid. posOut will be set to position in item, srcposOutOptional will be set to source media position. Returns index. if input index is -1, the following marker is found using position (or source position if position is -1). If position/source position are used to find marker position, their values are not updated.
GetTakeStretchMarker: *fn (*MediaItem_Take take, c_int idx, *double posOut, *double srcposOutOptional) callconv(.C) c_int;

/// GetTakeStretchMarkerSlope
/// See SetTakeStretchMarkerSlope
GetTakeStretchMarkerSlope: *fn (*MediaItem_Take take, c_int idx) callconv(.C) double;

/// GetTCPFXParm
/// Get information about a specific FX parameter knob (see CountTCPFXParms).
GetTCPFXParm: *fn (*ReaProject project, *MediaTrack track, c_int index, *c_int fxindexOut, *c_int parmidxOut) callconv(.C) bool;

/// GetTempoMatchPlayRate
/// finds the playrate and target length to insert this item stretched to a round power-of-2 number of bars, between 1/8 and 256
GetTempoMatchPlayRate: *fn (*PCM_source source, double srcscale, double position, double mult, *double rateOut, *double targetlenOut) callconv(.C) bool;

/// GetTempoTimeSigMarker
/// Get information about a tempo/time signature marker. See CountTempoTimeSigMarkers, SetTempoTimeSigMarker, AddTempoTimeSigMarker.
GetTempoTimeSigMarker: *fn (*ReaProject proj, c_int ptidx, *double timeposOut, *c_int measureposOut, *double beatposOut, *double bpmOut, *c_int timesig_numOut, *c_int timesig_denomOut, *bool lineartempoOut) callconv(.C) bool;

/// GetThemeColor
/// Returns the theme color specified, or -1 on failure. If the low bit of flags is set, the color as originally specified by the theme (before any transformations) is returned, otherwise the current (possibly transformed and modified) color is returned. See SetThemeColor for a list of valid ini_key.
GetThemeColor: *fn (const *c_char ini_key, c_int flagsOptional) callconv(.C) c_int;

/// GetThingFromPoint
/// Hit tests a point in screen coordinates. Updates infoOut with information such as "arrange", "fx_chain", "fx_0" (first FX in chain, floating), "spacer_0" (spacer before first track). If a track panel is hit, string will begin with "tcp" or "mcp" or "tcp.mute" etc (future versions may append additional information). May return NULL with valid info string to indicate non-track thing.
GetThingFromPoint: *fn (c_int screen_x, c_int screen_y, *c_char infoOut, c_int infoOut_sz) callconv(.C) *MediaTrack;

/// GetToggleCommandState
/// See GetToggleCommandStateEx.
GetToggleCommandState: *fn (c_int command_id) callconv(.C) c_int;

/// GetToggleCommandState2
/// See GetToggleCommandStateEx.
GetToggleCommandState2: *fn (*KbdSectionInfo section, c_int command_id) callconv(.C) c_int;

/// GetToggleCommandStateEx
/// For the main action context, the MIDI editor, or the media explorer, returns the toggle state of the action. 0=off, 1=on, -1=NA because the action does not have on/off states. For the MIDI editor, the action state for the most recently focused window will be returned.
GetToggleCommandStateEx: *fn (c_int section_id, c_int command_id) callconv(.C) c_int;

/// GetToggleCommandStateThroughHooks
/// Returns the state of an action via extension plugins' hooks.
GetToggleCommandStateThroughHooks: *fn (*KbdSectionInfo section, c_int command_id) callconv(.C) c_int;

/// GetTooltipWindow
/// gets a tooltip window,in case you want to ask it for font information. Can return NULL.
GetTooltipWindow: *fn () callconv(.C) HWND;

/// GetTouchedOrFocusedFX
/// mode can be 0 to query last touched parameter, or 1 to query currently focused FX. Returns false if failed. If successful, trackIdxOut will be track index (-1 is master track, 0 is first track). itemidxOut will be 0-based item index if an item, or -1 if not an item. takeidxOut will be 0-based take index. fxidxOut will be FX index, potentially with 0x2000000 set to signify container-addressing, or with 0x1000000 set to signify record-input FX. parmOut will be set to the parameter index if querying last-touched. parmOut will have 1 set if querying focused state and FX is no longer focused but still open.
GetTouchedOrFocusedFX: *fn (c_int mode, *c_int trackidxOut, *c_int itemidxOut, *c_int takeidxOut, *c_int fxidxOut, *c_int parmOut) callconv(.C) bool;

/// GetTrack
/// get a track from a project by track count (zero-based) (proj=0 for active project)
GetTrack: *fn (*ReaProject proj, c_int trackidx) callconv(.C) *MediaTrack;

/// GetTrackAutomationMode
/// return the track mode, regardless of global override
GetTrackAutomationMode: *fn (*MediaTrack tr) callconv(.C) c_int;

/// GetTrackColor
/// Returns the track custom color as OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). Black is returned as 0x1000000, no color setting is returned as 0.
GetTrackColor: *fn (*MediaTrack track) callconv(.C) c_int;

/// GetTrackDepth
GetTrackDepth: *fn (*MediaTrack track) callconv(.C) c_int;

/// GetTrackEnvelope
GetTrackEnvelope: *fn (*MediaTrack track, c_int envidx) callconv(.C) *TrackEnvelope;

/// GetTrackEnvelopeByChunkName
/// Gets a built-in track envelope by configuration chunk name, like "<VOLENV", or GUID string, like "{B577250D-146F-B544-9B34-F24FBE488F1F}".
/// 
GetTrackEnvelopeByChunkName: *fn (*MediaTrack tr, const *c_char cfgchunkname_or_guid) callconv(.C) *TrackEnvelope;

/// GetTrackEnvelopeByName
GetTrackEnvelopeByName: *fn (*MediaTrack track, const *c_char envname) callconv(.C) *TrackEnvelope;

/// GetTrackFromPoint
/// Returns the track from the screen coordinates specified. If the screen coordinates refer to a window associated to the track (such as FX), the track will be returned. infoOutOptional will be set to 1 if it is likely an envelope, 2 if it is likely a track FX. For a free item positioning or fixed lane track, the second byte of infoOutOptional will be set to the (approximate, for fipm tracks) item lane underneath the mouse. See GetThingFromPoint.
GetTrackFromPoint: *fn (c_int screen_x, c_int screen_y, *c_int infoOutOptional) callconv(.C) *MediaTrack;

/// GetTrackGUID
GetTrackGUID: *fn (*MediaTrack tr) callconv(.C) *GUID;

/// GetTrackInfo
/// gets track info (returns name).
/// track index, -1=master, 0..n, or cast a *MediaTrack to c_int
/// if flags is non-NULL, will be set to:
/// &1=folder
/// &2=selected
/// &4=has fx enabled
/// &8=muted
/// &16=soloed
/// &32=SIP'd (with &16)
/// &64=rec armed
/// &128=rec monitoring on
/// &256=rec monitoring auto
/// &512=hide from TCP
/// &1024=hide from MCP
GetTrackInfo: *fn (INT_PTR track, *c_int flags) callconv(.C) const *c_char ; //TODO check me

/// GetTrackMediaItem
GetTrackMediaItem: *fn (*MediaTrack tr, c_int itemidx) callconv(.C) *MediaItem;

/// GetTrackMIDILyrics
/// Get all MIDI lyrics on the track. Lyrics will be returned as one string with tabs between each word. flag&1: double tabs at the end of each measure and triple tabs when skipping measures, flag&2: each lyric is preceded by its beat position in the project (example with flag=2: "1.1.2\tLyric for measure 1 beat 2\t2.1.1\tLyric for measure 2 beat 1	"). See SetTrackMIDILyrics
GetTrackMIDILyrics: *fn (*MediaTrack track, c_int flag, *c_char bufOutWantNeedBig, *c_int bufOutWantNeedBig_sz) callconv(.C) bool;

/// GetTrackMIDINoteName
/// see GetTrackMIDINoteNameEx
GetTrackMIDINoteName: *fn (c_int track, c_int pitch, c_int chan) callconv(.C) const *c_char ; //TODO check me

/// GetTrackMIDINoteNameEx
/// Get note/CC name. pitch 128 for CC0 name, 129 for CC1 name, etc. See SetTrackMIDINoteNameEx
GetTrackMIDINoteNameEx: *fn (*ReaProject proj, *MediaTrack track, c_int pitch, c_int chan) callconv(.C) const *c_char ; //TODO check me

/// GetTrackMIDINoteRange
GetTrackMIDINoteRange: *fn (*ReaProject proj, *MediaTrack track, *c_int note_loOut, *c_int note_hiOut) callconv(.C) void;

/// GetTrackName
/// Returns "MASTER" for master track, "Track N" if track has no name.
GetTrackName: *fn (*MediaTrack track, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// GetTrackNumMediaItems
GetTrackNumMediaItems: *fn (*MediaTrack tr) callconv(.C) c_int;

/// GetTrackNumSends
/// returns number of sends/receives/hardware outputs - category is <0 for receives, 0=sends, >0 for hardware outputs
GetTrackNumSends: *fn (*MediaTrack tr, c_int category) callconv(.C) c_int;

/// GetTrackReceiveName
/// See GetTrackSendName.
GetTrackReceiveName: *fn (*MediaTrack track, c_int recv_index, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// GetTrackReceiveUIMute
/// See GetTrackSendUIMute.
GetTrackReceiveUIMute: *fn (*MediaTrack track, c_int recv_index, *bool muteOut) callconv(.C) bool;

/// GetTrackReceiveUIVolPan
/// See GetTrackSendUIVolPan.
GetTrackReceiveUIVolPan: *fn (*MediaTrack track, c_int recv_index, *double volumeOut, *double panOut) callconv(.C) bool;

/// GetTrackSendInfo_Value
/// Get send/receive/hardware output numerical-value attributes.
/// category is <0 for receives, 0=sends, >0 for hardware outputs
/// parameter names:
/// B_MUTE : bool *
/// B_PHASE : bool * : true to flip phase
/// B_MONO : bool *
/// D_VOL : double * : 1.0 = +0dB etc
/// D_PAN : double * : -1..+1
/// D_PANLAW : double * : 1.0=+0.0db, 0.5=-6dB, -1.0 = projdef etc
/// I_SENDMODE : c_int * : 0=post-fader, 1=pre-fx, 2=post-fx (deprecated), 3=post-fx
/// I_AUTOMODE : c_int * : automation mode (-1=use track automode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch)
/// I_SRCCHAN : c_int * : -1 for no audio send. Low 10 bits specify channel offset, and higher bits specify channel count. (srcchan>>10) == 0 for stereo, 1 for mono, 2 for 4 channel, 3 for 6 channel, etc.
/// I_DSTCHAN : c_int * : low 10 bits are destination index, &1024 set to mix to mono.
/// I_MIDIFLAGS : c_int * : low 5 bits=source channel 0=all, 1-16, 31=MIDI send disabled, next 5 bits=dest channel, 0=orig, 1-16=chan. &1024 for faders-send MIDI vol/pan. (>>14)&255 = src bus (0 for all, 1 for normal, 2+). (>>22)&255=destination bus (0 for all, 1 for normal, 2+)
/// P_DESTTRACK : MediaTrack * : destination track, only applies for sends/recvs (read-only)
/// P_SRCTRACK : MediaTrack * : source track, only applies for sends/recvs (read-only)
/// P_ENV:<envchunkname : TrackEnvelope * : call with :<VOLENV, :<PANENV, etc appended (read-only)
/// See CreateTrackSend, RemoveTrackSend, GetTrackNumSends.
GetTrackSendInfo_Value: *fn (*MediaTrack tr, c_int category, c_int sendidx, const *c_char parmname) callconv(.C) double;

/// GetTrackSendName
/// send_idx>=0 for hw ouputs, >=nb_of_hw_ouputs for sends. See GetTrackReceiveName.
GetTrackSendName: *fn (*MediaTrack track, c_int send_index, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// GetTrackSendUIMute
/// send_idx>=0 for hw ouputs, >=nb_of_hw_ouputs for sends. See GetTrackReceiveUIMute.
GetTrackSendUIMute: *fn (*MediaTrack track, c_int send_index, *bool muteOut) callconv(.C) bool;

/// GetTrackSendUIVolPan
/// send_idx>=0 for hw ouputs, >=nb_of_hw_ouputs for sends. See GetTrackReceiveUIVolPan.
GetTrackSendUIVolPan: *fn (*MediaTrack track, c_int send_index, *double volumeOut, *double panOut) callconv(.C) bool;

/// GetTrackState
/// Gets track state, returns track name.
/// flags will be set to:
/// &1=folder
/// &2=selected
/// &4=has fx enabled
/// &8=muted
/// &16=soloed
/// &32=SIP'd (with &16)
/// &64=rec armed
/// &128=rec monitoring on
/// &256=rec monitoring auto
/// &512=hide from TCP
/// &1024=hide from MCP
GetTrackState: *fn (*MediaTrack track, *c_int flagsOut) callconv(.C) const *c_char ; //TODO check me

/// GetTrackStateChunk
/// Gets the RPPXML state of a track, returns true if successful. Undo flag is a performance/caching hint.
GetTrackStateChunk: *fn (*MediaTrack track, *c_char strNeedBig, c_int strNeedBig_sz, bool isundoOptional) callconv(.C) bool;

/// GetTrackUIMute
GetTrackUIMute: *fn (*MediaTrack track, *bool muteOut) callconv(.C) bool;

/// GetTrackUIPan
GetTrackUIPan: *fn (*MediaTrack track, *double pan1Out, *double pan2Out, *c_int panmodeOut) callconv(.C) bool;

/// GetTrackUIVolPan
GetTrackUIVolPan: *fn (*MediaTrack track, *double volumeOut, *double panOut) callconv(.C) bool;

/// GetUnderrunTime
/// retrieves the last timestamps of audio xrun (yellow-flash, if available), media xrun (red-flash), and the current time stamp (all milliseconds)
GetUnderrunTime: *fn (unsigned *c_int audio_xrunOut, unsigned *c_int media_xrunOut, unsigned *c_int curtimeOut) callconv(.C) void;

/// GetUserFileNameForRead
/// returns true if the user selected a valid file, false if the user canceled the dialog
GetUserFileNameForRead: *fn (*c_char filenameNeed4096, const *c_char title, const *c_char defext) callconv(.C) bool;

/// GetUserInputs
/// Get values from the user.
/// If a caption begins with *, for example "*password", the edit field will not display the input text.
/// Maximum fields is 16. Values are returned as a comma-separated string. Returns false if the user canceled the dialog. You can supply special extra information via additional caption fields: extrawidth=XXX to increase text field width, separator=X to use a different separator for returned fields.
GetUserInputs: *fn (const *c_char title, c_int num_inputs, const *c_char captions_csv, *c_char retvals_csv, c_int retvals_csv_sz) callconv(.C) bool;

/// GoToMarker
/// Go to marker. If use_timeline_order==true, marker_index 1 refers to the first marker on the timeline.  If use_timeline_order==false, marker_index 1 refers to the first marker with the user-editable index of 1.
GoToMarker: *fn (*ReaProject proj, c_int marker_index, bool use_timeline_order) callconv(.C) void;

/// GoToRegion
/// Seek to region after current region finishes playing (smooth seek). If use_timeline_order==true, region_index 1 refers to the first region on the timeline.  If use_timeline_order==false, region_index 1 refers to the first region with the user-editable index of 1.
GoToRegion: *fn (*ReaProject proj, c_int region_index, bool use_timeline_order) callconv(.C) void;

/// GR_SelectColor
/// Runs the system color chooser dialog.  Returns 0 if the user cancels the dialog.
GR_SelectColor: *fn (HWND hwnd, *c_int colorOut) callconv(.C) c_int;

/// GSC_mainwnd
/// this is just like win32 GetSysColor() but can have overrides.
GSC_mainwnd: *fn (c_int t) callconv(.C) c_int;

/// guidToString
/// dest should be at least 64 c_chars long to be safe
guidToString: *fn (const *GUID g, *c_char destNeed64) callconv(.C) void;

/// HasExtState
/// Returns true if there exists an extended state value for a specific section and key. See SetExtState, GetExtState, DeleteExtState.
HasExtState: *fn (const *c_char section, const *c_char key) callconv(.C) bool;

/// HasTrackMIDIPrograms
/// returns name of track plugin that is supplying MIDI programs,or NULL if there is none
HasTrackMIDIPrograms: *fn (c_int track) callconv(.C) const *c_char ; //TODO check me

/// HasTrackMIDIProgramsEx
/// returns name of track plugin that is supplying MIDI programs,or NULL if there is none
HasTrackMIDIProgramsEx: *fn (*ReaProject proj, *MediaTrack track) callconv(.C) const *c_char ; //TODO check me

/// Help_Set
Help_Set: *fn (const *c_char helpstring, bool is_temporary_help) callconv(.C) void;

/// HiresPeaksFromSource
HiresPeaksFromSource: *fn (*PCM_source src, *PCM_source_peaktransfer_t block) callconv(.C) void;

/// image_resolve_fn
image_resolve_fn: *fn (const *c_char in, *c_char out, c_int out_sz) callconv(.C) void;

/// InsertAutomationItem
/// Insert a new automation item. pool_id < 0 collects existing envelope points into the automation item; if pool_id is >= 0 the automation item will be a new instance of that pool (which will be created as an empty instance if it does not exist). Returns the index of the item, suitable for passing to other automation item API functions. See GetSetAutomationItemInfo.
InsertAutomationItem: *fn (*TrackEnvelope env, c_int pool_id, double position, double length) callconv(.C) c_int;

/// InsertEnvelopePoint
/// Insert an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done. See InsertEnvelopePointEx.
InsertEnvelopePoint: *fn (*TrackEnvelope envelope, double time, double value, c_int shape, double tension, bool selected, *bool noSortInOptional) callconv(.C) bool;

/// InsertEnvelopePointEx
/// Insert an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
/// autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
/// For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
/// even if the automation item is trimmed so that not all points are visible.
/// Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
/// See CountEnvelopePointsEx, GetEnvelopePointEx, SetEnvelopePointEx, DeleteEnvelopePointEx.
InsertEnvelopePointEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx, double time, double value, c_int shape, double tension, bool selected, *bool noSortInOptional) callconv(.C) bool;

/// InsertMedia
/// mode: 0=add to current track, 1=add new track, 3=add to selected items as takes, &4=stretch/loop to fit time sel, &8=try to match tempo 1x, &16=try to match tempo 0.5x, &32=try to match tempo 2x, &64=don't preserve pitch when matching tempo, &128=no loop/section if startpct/endpct set, &256=force loop regardless of global preference for looping imported items, &512=use high word as absolute track index if mode&3==0 or mode&2048, &1024=insert into reasamplomatic on a new track (add 1 to insert on last selected track), &2048=insert into open reasamplomatic instance (add 512 to use high word as absolute track index), &4096=move to source preferred position (BWF start offset), &8192=reverse
InsertMedia: *fn (const *c_char file, c_int mode) callconv(.C) c_int;

/// InsertMediaSection
/// See InsertMedia.
InsertMediaSection: *fn (const *c_char file, c_int mode, double startpct, double endpct, double pitchshift) callconv(.C) c_int;

/// InsertTrackAtIndex
/// inserts a track at idx,of course this will be clamped to 0..GetNumTracks(). wantDefaults=TRUE for default envelopes/FX,otherwise no enabled fx/env
InsertTrackAtIndex: *fn (c_int idx, bool wantDefaults) callconv(.C) void;

/// IsInRealTimeAudio
/// are we in a realtime audio thread (between OnAudioBuffer calls,not in some worker/anticipative FX thread)? threadsafe
IsInRealTimeAudio: *fn () callconv(.C) c_int;

/// IsItemTakeActiveForPlayback
/// get whether a take will be played (active take, unmuted, etc)
IsItemTakeActiveForPlayback: *fn (*MediaItem item, *MediaItem_Take take) callconv(.C) bool;

/// IsMediaExtension
/// Tests a file extension (i.e. "wav" or "mid") to see if it's a media extension.
/// If wantOthers is set, then "RPP", "TXT" and other project-type formats will also pass.
IsMediaExtension: *fn (const *c_char ext, bool wantOthers) callconv(.C) bool;

/// IsMediaItemSelected
IsMediaItemSelected: *fn (*MediaItem item) callconv(.C) bool;

/// IsProjectDirty
/// Is the project dirty (needing save)? Always returns 0 if 'undo/prompt to save' is disabled in preferences.
IsProjectDirty: *fn (*ReaProject proj) callconv(.C) c_int;

/// IsREAPER
/// Returns true if dealing with REAPER, returns false for ReaMote, etc
IsREAPER: *fn () callconv(.C) bool;

/// IsTrackSelected
IsTrackSelected: *fn (*MediaTrack track) callconv(.C) bool;

/// IsTrackVisible
/// If mixer==true, returns true if the track is visible in the mixer.  If mixer==false, returns true if the track is visible in the track control panel.
IsTrackVisible: *fn (*MediaTrack track, bool mixer) callconv(.C) bool;

/// joystick_create
/// creates a joystick device
joystick_create(const *GUID guid) callconv(.C) *joystick *fn_device ; //TODO check me

/// joystick_destroy
/// destroys a joystick device
joystick_destroy: *fn (*joystick_device device) callconv(.C) void;

/// joystick_enum
/// enumerates installed devices, returns GUID as a string
joystick_enum: *fn (c_int index, const *c_char* namestrOutOptional) callconv(.C) const *c_char ; //TODO check me

/// joystick_getaxis
/// returns axis value (-1..1)
joystick_getaxis: *fn (*joystick_device dev, c_int axis) callconv(.C) double;

/// joystick_getbuttonmask
/// returns button pressed mask, 1=first button, 2=second...
c_int joystick_getbuttonmask: *fn (*joystick_device dev) callconv(.C) unsigned;

/// joystick_getinfo
/// returns button count
joystick_getinfo: *fn (*joystick_device dev, *c_int axesOutOptional, *c_int povsOutOptional) callconv(.C) c_int;

/// joystick_getpov
/// returns POV value (usually 0..655.35, or 655.35 on error)
joystick_getpov: *fn (*joystick_device dev, c_int pov) callconv(.C) double;

/// joystick_update
/// Updates joystick state from hardware, returns true if successful (*joystick_get will not be valid until joystick_update() is called successfully)
joystick_update: *fn (*joystick_device dev) callconv(.C) bool;

/// kbd_enumerateActions
kbd_enumerateActions: *fn (*KbdSectionInfo section, c_int idx, const *c_char* nameOut) callconv(.C) c_int;

/// kbd_formatKeyName
kbd_formatKeyName: *fn (*ACCEL ac, *c_char s) callconv(.C) void;

/// kbd_getCommandName
/// Get the string of a key assigned to command "cmd" in a section.
/// This function is poorly named as it doesn't return the command's name, see kbd_getTextFromCmd.
kbd_getCommandName: *fn (c_int cmd, *c_char s, *KbdSectionInfo section) callconv(.C) void;

/// kbd_getTextFromCmd
kbd_getTextFromCmd: *fn (c_int cmd, *KbdSectionInfo section) callconv(.C) const *c_char ; //TODO check me

/// KBD_OnMainActionEx
/// val/valhw are used for midi stuff.
/// val=[0..127] and valhw=-1 (midi CC),
/// valhw >=0 (midi pitch (valhw | val<<7)),
/// relmode absolute (0) or 1/2/3 for relative adjust modes
KBD_OnMainActionEx: *fn (c_int cmd, c_int val, c_int valhw, c_int relmode, HWND hwnd, *ReaProject proj) callconv(.C) c_int;

/// kbd_OnMidiEvent
/// can be called from anywhere (threadsafe)
kbd_OnMidiEvent: *fn (*MIDI_event_t evt, c_int dev_index) callconv(.C) void;

/// kbd_OnMidiList
/// can be called from anywhere (threadsafe)
kbd_OnMidiList: *fn (*MIDI_eventlist list, c_int dev_index) callconv(.C) void;

/// kbd_ProcessActionsMenu
kbd_ProcessActionsMenu: *fn (HMENU menu, *KbdSectionInfo section) callconv(.C) void;

/// kbd_processMidiEventActionEx
kbd_processMidiEventActionEx: *fn (*MIDI_event_t evt, *KbdSectionInfo section, HWND hwndCtx) callconv(.C) bool;

/// kbd_reprocessMenu
/// Reprocess a menu recursively, setting key assignments to what their command IDs are mapped to.
kbd_reprocessMenu: *fn (HMENU menu, *KbdSectionInfo section) callconv(.C) void;

/// kbd_RunCommandThroughHooks
/// actioncommandID may get modified
kbd_RunCommandThroughHooks: *fn (*KbdSectionInfo section, const *c_int actionCommandID, const *c_int val, const *c_int valhw, const *c_int relmode, HWND hwnd) callconv(.C) bool;

/// kbd_translateAccelerator
/// Pass in the HWND to receive commands, a MSG of a key command,  and a valid section,
/// and kbd_translateAccelerator() will process it looking for any keys bound to it, and send the messages off.
/// Returns 1 if processed, 0 if no key binding found.
kbd_translateAccelerator: *fn (HWND hwnd, *MSG msg, *KbdSectionInfo section) callconv(.C) c_int;

/// LICE__Destroy
LICE__Destroy: *fn (*LICE_IBitmap bm) callconv(.C) void;

/// LICE__DestroyFont
LICE__DestroyFont: *fn (*LICE_IFont font) callconv(.C) void;

/// LICE__DrawText
LICE__DrawText: *fn (*LICE_IFont font, *LICE_IBitmap bm, const *c_char str, c_int strcnt, *RECT rect, UINT dtFlags) callconv(.C) c_int;

/// LICE__GetBits
LICE__GetBits: *fn (*LICE_IBitmap bm) callconv(.C) *void;

/// LICE__GetDC
LICE__GetDC: *fn (*LICE_IBitmap bm) callconv(.C) HDC;

/// LICE__GetHeight
LICE__GetHeight: *fn (*LICE_IBitmap bm) callconv(.C) c_int;

/// LICE__GetRowSpan
LICE__GetRowSpan: *fn (*LICE_IBitmap bm) callconv(.C) c_int;

/// LICE__GetWidth
LICE__GetWidth: *fn (*LICE_IBitmap bm) callconv(.C) c_int;

/// LICE__IsFlipped
LICE__IsFlipped: *fn (*LICE_IBitmap bm) callconv(.C) bool;

/// LICE__resize
LICE__resize: *fn (*LICE_IBitmap bm, c_int w, c_int h) callconv(.C) bool;

/// LICE__SetBkColor
LICE__SetBkColor(*LICE_IFont font, LICE_pixel color) callconv(.C) LICE *fn_pixel ; //TODO check me

/// LICE__SetFromHFont
/// font must REMAIN valid,unless LICE_FONT_FLAG_PRECALCALL is set
LICE__SetFromHFont: *fn (*LICE_IFont font, HFONT hfont, c_int flags) callconv(.C) void;

/// LICE__SetTextColor
LICE__SetTextColor(*LICE_IFont font, LICE_pixel color) callconv(.C) LICE *fn_pixel ; //TODO check me

/// LICE__SetTextCombineMode
LICE__SetTextCombineMode: *fn (*LICE_IFont ifont, c_int mode, float alpha) callconv(.C) void;

/// LICE_Arc
LICE_Arc: *fn (*LICE_IBitmap dest, float cx, float cy, float r, float minAngle, float maxAngle, LICE_pixel color, float alpha, c_int mode, bool aa) callconv(.C) void;

/// LICE_Blit
LICE_Blit: *fn (*LICE_IBitmap dest, *LICE_IBitmap src, c_int dstx, c_int dsty, c_int srcx, c_int srcy, c_int srcw, c_int srch, float alpha, c_int mode) callconv(.C) void;

/// LICE_Blur
LICE_Blur: *fn (*LICE_IBitmap dest, *LICE_IBitmap src, c_int dstx, c_int dsty, c_int srcx, c_int srcy, c_int srcw, c_int srch) callconv(.C) void;

/// LICE_BorderedRect
LICE_BorderedRect: *fn (*LICE_IBitmap dest, c_int x, c_int y, c_int w, c_int h, LICE_pixel bgcolor, LICE_pixel fgcolor, float alpha, c_int mode) callconv(.C) void;

/// LICE_Circle
LICE_Circle: *fn (*LICE_IBitmap dest, float cx, float cy, float r, LICE_pixel color, float alpha, c_int mode, bool aa) callconv(.C) void;

/// LICE_Clear
LICE_Clear: *fn (*LICE_IBitmap dest, LICE_pixel color) callconv(.C) void;

/// LICE_ClearRect
LICE_ClearRect: *fn (*LICE_IBitmap dest, c_int x, c_int y, c_int w, c_int h, LICE_pixel mask, LICE_pixel orbits) callconv(.C) void;

/// LICE_ClipLine
/// Returns false if the line is entirely offscreen.
LICE_ClipLine: *fn (*c_int pX1Out, *c_int pY1Out, *c_int pX2Out, *c_int pY2Out, c_int xLo, c_int yLo, c_int xHi, c_int yHi) callconv(.C) bool;

/// LICE_CombinePixels
LICE_CombinePixels(LICE_pixel dest, LICE_pixel src, float alpha, c_int mode) callconv(.C) LICE *fn_pixel ; //TODO check me

/// LICE_Copy
LICE_Copy: *fn (*LICE_IBitmap dest, *LICE_IBitmap src) callconv(.C) void;

/// LICE_CreateBitmap
/// create a new bitmap. this is like calling new LICE_MemBitmap (mode=0) or new LICE_SysBitmap (mode=1).
LICE_CreateBitmap(c_int mode, c_int w, c_int h) callconv(.C) *LICE *fn_IBitmap ; //TODO check me

/// LICE_CreateFont
LICE_CreateFont() callconv(.C) *LICE *fn_IFont ; //TODO check me

/// LICE_DrawCBezier
LICE_DrawCBezier: *fn (*LICE_IBitmap dest, double xstart, double ystart, double xctl1, double yctl1, double xctl2, double yctl2, double xend, double yend, LICE_pixel color, float alpha, c_int mode, bool aa, double tol) callconv(.C) void;

/// LICE_Drawc_char
LICE_Drawc_char: *fn (*LICE_IBitmap bm, c_int x, c_int y, c_char c, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_DrawGlyph
LICE_DrawGlyph: *fn (*LICE_IBitmap dest, c_int x, c_int y, LICE_pixel color, *LICE_pixel_chan alphas, c_int glyph_w, c_int glyph_h, float alpha, c_int mode) callconv(.C) void;

/// LICE_DrawRect
LICE_DrawRect: *fn (*LICE_IBitmap dest, c_int x, c_int y, c_int w, c_int h, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_DrawText
LICE_DrawText: *fn (*LICE_IBitmap bm, c_int x, c_int y, const *c_char string, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_FillCBezier
LICE_FillCBezier: *fn (*LICE_IBitmap dest, double xstart, double ystart, double xctl1, double yctl1, double xctl2, double yctl2, double xend, double yend, c_int yfill, LICE_pixel color, float alpha, c_int mode, bool aa, double tol) callconv(.C) void;

/// LICE_FillCircle
LICE_FillCircle: *fn (*LICE_IBitmap dest, float cx, float cy, float r, LICE_pixel color, float alpha, c_int mode, bool aa) callconv(.C) void;

/// LICE_FillConvexPolygon
LICE_FillConvexPolygon: *fn (*LICE_IBitmap dest, *c_int x, *c_int y, c_int npoints, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_FillRect
LICE_FillRect: *fn (*LICE_IBitmap dest, c_int x, c_int y, c_int w, c_int h, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_FillTrapezoid
LICE_FillTrapezoid: *fn (*LICE_IBitmap dest, c_int x1a, c_int x1b, c_int y1, c_int x2a, c_int x2b, c_int y2, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_FillTriangle
LICE_FillTriangle: *fn (*LICE_IBitmap dest, c_int x1, c_int y1, c_int x2, c_int y2, c_int x3, c_int y3, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_GetPixel
LICE_GetPixel(*LICE_IBitmap bm, c_int x, c_int y) callconv(.C) LICE *fn_pixel ; //TODO check me

/// LICE_GradRect
LICE_GradRect: *fn (*LICE_IBitmap dest, c_int dstx, c_int dsty, c_int dstw, c_int dsth, float ir, float ig, float ib, float ia, float drdx, float dgdx, float dbdx, float dadx, float drdy, float dgdy, float dbdy, float dady, c_int mode) callconv(.C) void;

/// LICE_Line
LICE_Line: *fn (*LICE_IBitmap dest, float x1, float y1, float x2, float y2, LICE_pixel color, float alpha, c_int mode, bool aa) callconv(.C) void;

/// LICE_LineInt
LICE_LineInt: *fn (*LICE_IBitmap dest, c_int x1, c_int y1, c_int x2, c_int y2, LICE_pixel color, float alpha, c_int mode, bool aa) callconv(.C) void;

/// LICE_LoadPNG
LICE_LoadPNG(const *c_char filename, *LICE_IBitmap bmp) callconv(.C) *LICE *fn_IBitmap ; //TODO check me

/// LICE_LoadPNGFromResource
LICE_LoadPNGFromResource(HINSTANCE hInst, const *c_char resid, *LICE_IBitmap bmp) callconv(.C) *LICE *fn_IBitmap ; //TODO check me

/// LICE_MeasureText
LICE_MeasureText: *fn (const *c_char string, *c_int w, *c_int h) callconv(.C) void;

/// LICE_MultiplyAddRect
LICE_MultiplyAddRect: *fn (*LICE_IBitmap dest, c_int x, c_int y, c_int w, c_int h, float rsc, float gsc, float bsc, float asc, float radd, float gadd, float badd, float aadd) callconv(.C) void;

/// LICE_PutPixel
LICE_PutPixel: *fn (*LICE_IBitmap bm, c_int x, c_int y, LICE_pixel color, float alpha, c_int mode) callconv(.C) void;

/// LICE_RotatedBlit
/// these coordinates are offset from the center of the image,in source pixel coordinates
LICE_RotatedBlit: *fn (*LICE_IBitmap dest, *LICE_IBitmap src, c_int dstx, c_int dsty, c_int dstw, c_int dsth, float srcx, float srcy, float srcw, float srch, float angle, bool cliptosourcerect, float alpha, c_int mode, float rotxcent, float rotycent) callconv(.C) void;

/// LICE_RoundRect
LICE_RoundRect: *fn (*LICE_IBitmap drawbm, float xpos, float ypos, float w, float h, c_int cornerradius, LICE_pixel col, float alpha, c_int mode, bool aa) callconv(.C) void;

/// LICE_ScaledBlit
LICE_ScaledBlit: *fn (*LICE_IBitmap dest, *LICE_IBitmap src, c_int dstx, c_int dsty, c_int dstw, c_int dsth, float srcx, float srcy, float srcw, float srch, float alpha, c_int mode) callconv(.C) void;

/// LICE_SimpleFill
LICE_SimpleFill: *fn (*LICE_IBitmap dest, c_int x, c_int y, LICE_pixel newcolor, LICE_pixel comparemask, LICE_pixel keepmask) callconv(.C) void;

/// LICE_ThickFLine
/// always AA. wid is not affected by scaling (1 is always normal line, 2 is always 2 physical pixels, etc)
LICE_ThickFLine: *fn (*LICE_IBitmap dest, double x1, double y1, double x2, double y2, LICE_pixel color, float alpha, c_int mode, c_int wid) callconv(.C) void;

/// LocalizeString
/// Returns a localized version of src_string, in section section. flags can have 1 set to only localize if sprintf-style formatting matches the original.
LocalizeString: *fn (const *c_char src_string, const *c_char section, c_int flagsOptional) callconv(.C) const *c_char ; //TODO check me

/// Loop_OnArrow
/// Move the loop selection left or right. Returns true if snap is enabled.
Loop_OnArrow: *fn (*ReaProject project, c_int direction) callconv(.C) bool;

/// Main_OnCommand
/// See Main_OnCommandEx.
Main_OnCommand: *fn (c_int command, c_int flag) callconv(.C) void;

/// Main_OnCommandEx
/// Performs an action belonging to the main action section. To perform non-native actions (ReaScripts, custom or extension plugins' actions) safely, see NamedCommandLookup().
Main_OnCommandEx: *fn (c_int command, c_int flag, *ReaProject proj) callconv(.C) void;

/// Main_openProject
/// opens a project. will prompt the user to save unless name is prefixed with 'noprompt:'. If name is prefixed with 'template:', project file will be loaded as a template.
/// If passed a .RTrackTemplate file, adds the template to the existing project.
Main_openProject: *fn (const *c_char name) callconv(.C) void;

/// Main_SaveProject
/// Save the project.
Main_SaveProject: *fn (*ReaProject proj, bool forceSaveAsInOptional) callconv(.C) void;

/// Main_SaveProjectEx
/// Save the project. options: &1=save selected tracks as track template, &2=include media with track template, &4=include envelopes with track template. See Main_openProject, Main_SaveProject.
Main_SaveProjectEx: *fn (*ReaProject proj, const *c_char filename, c_int options) callconv(.C) void;

/// Main_UpdateLoopInfo
Main_UpdateLoopInfo: *fn (c_int ignoremask) callconv(.C) void;

/// MarkProjectDirty
/// Marks project as dirty (needing save) if 'undo/prompt to save' is enabled in preferences.
MarkProjectDirty: *fn (*ReaProject proj) callconv(.C) void;

/// MarkTrackItemsDirty
/// If track is supplied, item is ignored
MarkTrackItemsDirty: *fn (*MediaTrack track, *MediaItem item) callconv(.C) void;

/// Master_GetPlayRate
Master_GetPlayRate: *fn (*ReaProject project) callconv(.C) double;

/// Master_GetPlayRateAtTime
Master_GetPlayRateAtTime: *fn (double time_s, *ReaProject proj) callconv(.C) double;

/// Master_GetTempo
Master_GetTempo: *fn () callconv(.C) double;

/// Master_NormalizePlayRate
/// Convert play rate to/from a value between 0 and 1, representing the position on the project playrate slider.
Master_NormalizePlayRate: *fn (double playrate, bool isnormalized) callconv(.C) double;

/// Master_NormalizeTempo
/// Convert the tempo to/from a value between 0 and 1, representing bpm in the range of 40-296 bpm.
Master_NormalizeTempo: *fn (double bpm, bool isnormalized) callconv(.C) double;

/// MB
/// type 0=OK,1=OKCANCEL,2=ABORTRETRYIGNORE,3=YESNOCANCEL,4=YESNO,5=RETRYCANCEL : ret 1=OK,2=CANCEL,3=ABORT,4=RETRY,5=IGNORE,6=YES,7=NO
MB: *fn (const *c_char msg, const *c_char title, c_int type) callconv(.C) c_int;

/// MediaItemDescendsFromTrack
/// Returns 1 if the track holds the item, 2 if the track is a folder containing the track that holds the item, etc.
MediaItemDescendsFromTrack: *fn (*MediaItem item, *MediaTrack track) callconv(.C) c_int;

/// Menu_GetHash
/// Get a string that only changes when menu/toolbar entries are added or removed (not re-ordered). Can be used to determine if a customized menu/toolbar differs from the default, or if the default changed after a menu/toolbar was customized. flag==0: current default menu/toolbar; flag==1: current customized menu/toolbar; flag==2: default menu/toolbar at the time the current menu/toolbar was most recently customized, if it was customized in REAPER v7.08 or later.
Menu_GetHash: *fn (const *c_char menuname, c_int flag, *c_char hashOut, c_int hashOut_sz) callconv(.C) bool;

/// MIDI_CountEvts
/// Count the number of notes, CC events, and text/sysex events in a given MIDI item.
MIDI_CountEvts: *fn (*MediaItem_Take take, *c_int notecntOut, *c_int ccevtcntOut, *c_int textsyxevtcntOut) callconv(.C) c_int;

/// MIDI_DeleteCC
/// Delete a MIDI CC event.
MIDI_DeleteCC: *fn (*MediaItem_Take take, c_int ccidx) callconv(.C) bool;

/// MIDI_DeleteEvt
/// Delete a MIDI event.
MIDI_DeleteEvt: *fn (*MediaItem_Take take, c_int evtidx) callconv(.C) bool;

/// MIDI_DeleteNote
/// Delete a MIDI note.
MIDI_DeleteNote: *fn (*MediaItem_Take take, c_int noteidx) callconv(.C) bool;

/// MIDI_DeleteTextSysexEvt
/// Delete a MIDI text or sysex event.
MIDI_DeleteTextSysexEvt: *fn (*MediaItem_Take take, c_int textsyxevtidx) callconv(.C) bool;

/// MIDI_DisableSort
/// Disable sorting for all MIDI insert, delete, get and set functions, until MIDI_Sort is called.
MIDI_DisableSort: *fn (*MediaItem_Take take) callconv(.C) void;

/// MIDI_EnumSelCC
/// Returns the index of the next selected MIDI CC event after ccidx (-1 if there are no more selected events).
MIDI_EnumSelCC: *fn (*MediaItem_Take take, c_int ccidx) callconv(.C) c_int;

/// MIDI_EnumSelEvts
/// Returns the index of the next selected MIDI event after evtidx (-1 if there are no more selected events).
MIDI_EnumSelEvts: *fn (*MediaItem_Take take, c_int evtidx) callconv(.C) c_int;

/// MIDI_EnumSelNotes
/// Returns the index of the next selected MIDI note after noteidx (-1 if there are no more selected events).
MIDI_EnumSelNotes: *fn (*MediaItem_Take take, c_int noteidx) callconv(.C) c_int;

/// MIDI_EnumSelTextSysexEvts
/// Returns the index of the next selected MIDI text/sysex event after textsyxidx (-1 if there are no more selected events).
MIDI_EnumSelTextSysexEvts: *fn (*MediaItem_Take take, c_int textsyxidx) callconv(.C) c_int;

/// MIDI_eventlist_Create
/// Create a MIDI_eventlist object. The returned object must be deleted with MIDI_eventlist_destroy().
MIDI_eventlist_Create() callconv(.C) *MIDI *fn_eventlist ; //TODO check me

/// MIDI_eventlist_Destroy
/// Destroy a MIDI_eventlist object that was created using MIDI_eventlist_Create().
MIDI_eventlist_Destroy: *fn (*MIDI_eventlist evtlist) callconv(.C) void;

/// MIDI_GetAllEvts
/// Get all MIDI data. MIDI buffer is returned as a list of { c_int offset, c_char flag, c_int msglen, unsigned c_char msg[] }.
/// offset: MIDI ticks from previous event
/// flag: &1=selected &2=muted
/// flag high 4 bits for CC shape: &16=linear, &32=slow start/end, &16|32=fast start, &64=fast end, &64|16=bezier
/// msg: the MIDI message.
/// A meta-event of type 0xF followed by 'CCBZ ' and 5 more bytes represents bezier curve data for the previous MIDI event: 1 byte for the bezier type (usually 0) and 4 bytes for the bezier tension as a float.
/// For tick intervals longer than a 32 bit word can represent, zero-length meta events may be placed between valid events.
/// See MIDI_SetAllEvts.
MIDI_GetAllEvts: *fn (*MediaItem_Take take, *c_char bufOutNeedBig, *c_int bufOutNeedBig_sz) callconv(.C) bool;

/// MIDI_GetCC
/// Get MIDI CC event properties.
MIDI_GetCC: *fn (*MediaItem_Take take, c_int ccidx, *bool selectedOut, *bool mutedOut, *double ppqposOut, *c_int chanmsgOut, *c_int chanOut, *c_int msg2Out, *c_int msg3Out) callconv(.C) bool;

/// MIDI_GetCCShape
/// Get CC shape and bezier tension. See MIDI_GetCC, MIDI_SetCCShape
MIDI_GetCCShape: *fn (*MediaItem_Take take, c_int ccidx, *c_int shapeOut, *double beztensionOut) callconv(.C) bool;

/// MIDI_GetEvt
/// Get MIDI event properties.
MIDI_GetEvt: *fn (*MediaItem_Take take, c_int evtidx, *bool selectedOut, *bool mutedOut, *double ppqposOut, *c_char msgOut, *c_int msgOut_sz) callconv(.C) bool;

/// MIDI_GetGrid
/// Returns the most recent MIDI editor grid size for this MIDI take, in QN. Swing is between 0 and 1. Note length is 0 if it follows the grid size.
MIDI_GetGrid: *fn (*MediaItem_Take take, *double swingOutOptional, *double noteLenOutOptional) callconv(.C) double;

/// MIDI_GetHash
/// Get a string that only changes when the MIDI data changes. If notesonly==true, then the string changes only when the MIDI notes change. See MIDI_GetTrackHash
MIDI_GetHash: *fn (*MediaItem_Take take, bool notesonly, *c_char hashOut, c_int hashOut_sz) callconv(.C) bool;

/// MIDI_GetNote
/// Get MIDI note properties.
MIDI_GetNote: *fn (*MediaItem_Take take, c_int noteidx, *bool selectedOut, *bool mutedOut, *double startppqposOut, *double endppqposOut, *c_int chanOut, *c_int pitchOut, *c_int velOut) callconv(.C) bool;

/// MIDI_GetPPQPos_EndOfMeasure
/// Returns the MIDI tick (ppq) position corresponding to the end of the measure.
MIDI_GetPPQPos_EndOfMeasure: *fn (*MediaItem_Take take, double ppqpos) callconv(.C) double;

/// MIDI_GetPPQPos_StartOfMeasure
/// Returns the MIDI tick (ppq) position corresponding to the start of the measure.
MIDI_GetPPQPos_StartOfMeasure: *fn (*MediaItem_Take take, double ppqpos) callconv(.C) double;

/// MIDI_GetPPQPosFromProjQN
/// Returns the MIDI tick (ppq) position corresponding to a specific project time in quarter notes.
MIDI_GetPPQPosFromProjQN: *fn (*MediaItem_Take take, double projqn) callconv(.C) double;

/// MIDI_GetPPQPosFromProjTime
/// Returns the MIDI tick (ppq) position corresponding to a specific project time in seconds.
MIDI_GetPPQPosFromProjTime: *fn (*MediaItem_Take take, double projtime) callconv(.C) double;

/// MIDI_GetProjQNFromPPQPos
/// Returns the project time in quarter notes corresponding to a specific MIDI tick (ppq) position.
MIDI_GetProjQNFromPPQPos: *fn (*MediaItem_Take take, double ppqpos) callconv(.C) double;

/// MIDI_GetProjTimeFromPPQPos
/// Returns the project time in seconds corresponding to a specific MIDI tick (ppq) position.
MIDI_GetProjTimeFromPPQPos: *fn (*MediaItem_Take take, double ppqpos) callconv(.C) double;

/// MIDI_GetRecentInputEvent
/// Gets a recent MIDI input event from the global history. idx=0 for the most recent event, which also latches to the latest MIDI event state (to get a more recent list, calling with idx=0 is necessary). idx=1 next most recent event, returns a non-zero sequence number for the event, or zero if no more events. tsOut will be set to the timestamp in samples relative to the current position (0 is current, -48000 is one second ago, etc). devIdxOut will have the low 16 bits set to the input device index, and 0x10000 will be set if device was enabled only for control. projPosOut will be set to project position in seconds if project was playing back at time of event, otherwise -1. Large SysEx events will not be included in this event list.
MIDI_GetRecentInputEvent: *fn (c_int idx, *c_char bufOut, *c_int bufOut_sz, *c_int tsOut, *c_int devIdxOut, *double projPosOut, *c_int projLoopCntOut) callconv(.C) c_int;

/// MIDI_GetScale
/// Get the active scale in the media source, if any. root 0=C, 1=C#, etc. scale &0x1=root, &0x2=minor 2nd, &0x4=major 2nd, &0x8=minor 3rd, &0xF=fourth, etc.
MIDI_GetScale: *fn (*MediaItem_Take take, *c_int rootOut, *c_int scaleOut, *c_char nameOut, c_int nameOut_sz) callconv(.C) bool;

/// MIDI_GetTextSysexEvt
/// Get MIDI meta-event properties. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event. For all other meta-messages, type is returned as -2 and msg returned as all zeroes. See MIDI_GetEvt.
MIDI_GetTextSysexEvt: *fn (*MediaItem_Take take, c_int textsyxevtidx, *bool selectedOutOptional, *bool mutedOutOptional, *double ppqposOutOptional, *c_int typeOutOptional, *c_char msgOptional, *c_int msgOptional_sz) callconv(.C) bool;

/// MIDI_GetTrackHash
/// Get a string that only changes when the MIDI data changes. If notesonly==true, then the string changes only when the MIDI notes change. See MIDI_GetHash
MIDI_GetTrackHash: *fn (*MediaTrack track, bool notesonly, *c_char hashOut, c_int hashOut_sz) callconv(.C) bool;

/// midi_init
/// Opens MIDI devices as configured in preferences. force_reinit_input and force_reinit_output force a particular device index to close/re-open (pass -1 to not force any devices to reopen).
midi_init: *fn (c_int force_reinit_input, c_int force_reinit_output) callconv(.C) void;

/// MIDI_InsertCC
/// Insert a new MIDI CC event.
MIDI_InsertCC: *fn (*MediaItem_Take take, bool selected, bool muted, double ppqpos, c_int chanmsg, c_int chan, c_int msg2, c_int msg3) callconv(.C) bool;

/// MIDI_InsertEvt
/// Insert a new MIDI event.
MIDI_InsertEvt: *fn (*MediaItem_Take take, bool selected, bool muted, double ppqpos, const *c_char bytestr, c_int bytestr_sz) callconv(.C) bool;

/// MIDI_InsertNote
/// Insert a new MIDI note. Set noSort if inserting multiple events, then call MIDI_Sort when done.
MIDI_InsertNote: *fn (*MediaItem_Take take, bool selected, bool muted, double startppqpos, double endppqpos, c_int chan, c_int pitch, c_int vel, const *bool noSortInOptional) callconv(.C) bool;

/// MIDI_InsertTextSysexEvt
/// Insert a new MIDI text or sysex event. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event.
MIDI_InsertTextSysexEvt: *fn (*MediaItem_Take take, bool selected, bool muted, double ppqpos, c_int type, const *c_char bytestr, c_int bytestr_sz) callconv(.C) bool;

/// midi_reinit
/// Reset (close and re-open) all MIDI devices
midi_reinit: *fn () callconv(.C) void;

/// MIDI_SelectAll
/// Select or deselect all MIDI content.
MIDI_SelectAll: *fn (*MediaItem_Take take, bool select) callconv(.C) void;

/// MIDI_SetAllEvts
/// Set all MIDI data. MIDI buffer is passed in as a list of { c_int offset, c_char flag, c_int msglen, unsigned c_char msg[] }.
/// offset: MIDI ticks from previous event
/// flag: &1=selected &2=muted
/// flag high 4 bits for CC shape: &16=linear, &32=slow start/end, &16|32=fast start, &64=fast end, &64|16=bezier
/// msg: the MIDI message.
/// A meta-event of type 0xF followed by 'CCBZ ' and 5 more bytes represents bezier curve data for the previous MIDI event: 1 byte for the bezier type (usually 0) and 4 bytes for the bezier tension as a float.
/// For tick intervals longer than a 32 bit word can represent, zero-length meta events may be placed between valid events.
/// See MIDI_GetAllEvts.
MIDI_SetAllEvts: *fn (*MediaItem_Take take, const *c_char buf, c_int buf_sz) callconv(.C) bool;

/// MIDI_SetCC
/// Set MIDI CC event properties. Properties passed as NULL will not be set. set noSort if setting multiple events, then call MIDI_Sort when done.
MIDI_SetCC: *fn (*MediaItem_Take take, c_int ccidx, const *bool selectedInOptional, const *bool mutedInOptional, const *double ppqposInOptional, const *c_int chanmsgInOptional, const *c_int chanInOptional, const *c_int msg2InOptional, const *c_int msg3InOptional, const *bool noSortInOptional) callconv(.C) bool;

/// MIDI_SetCCShape
/// Set CC shape and bezier tension. set noSort if setting multiple events, then call MIDI_Sort when done. See MIDI_SetCC, MIDI_GetCCShape
MIDI_SetCCShape: *fn (*MediaItem_Take take, c_int ccidx, c_int shape, double beztension, const *bool noSortInOptional) callconv(.C) bool;

/// MIDI_SetEvt
/// Set MIDI event properties. Properties passed as NULL will not be set.  set noSort if setting multiple events, then call MIDI_Sort when done.
MIDI_SetEvt: *fn (*MediaItem_Take take, c_int evtidx, const *bool selectedInOptional, const *bool mutedInOptional, const *double ppqposInOptional, const *c_char msgOptional, c_int msgOptional_sz, const *bool noSortInOptional) callconv(.C) bool;

/// MIDI_SetItemExtents
/// Set the start/end positions of a media item that contains a MIDI take.
MIDI_SetItemExtents: *fn (*MediaItem item, double startQN, double endQN) callconv(.C) bool;

/// MIDI_SetNote
/// Set MIDI note properties. Properties passed as NULL (or negative values) will not be set. Set noSort if setting multiple events, then call MIDI_Sort when done. Setting multiple note start positions at once is done more safely by deleting and re-inserting the notes.
MIDI_SetNote: *fn (*MediaItem_Take take, c_int noteidx, const *bool selectedInOptional, const *bool mutedInOptional, const *double startppqposInOptional, const *double endppqposInOptional, const *c_int chanInOptional, const *c_int pitchInOptional, const *c_int velInOptional, const *bool noSortInOptional) callconv(.C) bool;

/// MIDI_SetTextSysexEvt
/// Set MIDI text or sysex event properties. Properties passed as NULL will not be set. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event. set noSort if setting multiple events, then call MIDI_Sort when done.
MIDI_SetTextSysexEvt: *fn (*MediaItem_Take take, c_int textsyxevtidx, const *bool selectedInOptional, const *bool mutedInOptional, const *double ppqposInOptional, const *c_int typeInOptional, const *c_char msgOptional, c_int msgOptional_sz, const *bool noSortInOptional) callconv(.C) bool;

/// MIDI_Sort
/// Sort MIDI events after multiple calls to MIDI_SetNote, MIDI_SetCC, etc.
MIDI_Sort: *fn (*MediaItem_Take take) callconv(.C) void;

/// MIDIEditor_EnumTakes
/// list the takes that are currently being edited in this MIDI editor, starting with the active take. See MIDIEditor_GetTake
MIDIEditor_EnumTakes(HWND midieditor, c_int takeindex, bool editable_only) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// MIDIEditor_GetActive
/// get a pointer to the focused MIDI editor window
/// see MIDIEditor_GetMode, MIDIEditor_OnCommand
MIDIEditor_GetActive: *fn () callconv(.C) HWND;

/// MIDIEditor_GetMode
/// get the mode of a MIDI editor (0=piano roll, 1=event list, -1=invalid editor)
/// see MIDIEditor_GetActive, MIDIEditor_OnCommand
MIDIEditor_GetMode: *fn (HWND midieditor) callconv(.C) c_int;

/// MIDIEditor_GetSetting_int
/// Get settings from a MIDI editor. setting_desc can be:
/// snap_enabled: returns 0 or 1
/// active_note_row: returns 0-127
/// last_clicked_cc_lane: returns 0-127=CC, 0x100|(0-31)=14-bit CC, 0x200=velocity, 0x201=pitch, 0x202=program, 0x203=channel pressure, 0x204=bank/program select, 0x205=text, 0x206=sysex, 0x207=off velocity, 0x208=notation events, 0x210=media item lane
/// default_note_vel: returns 0-127
/// default_note_chan: returns 0-15
/// default_note_len: returns default length in MIDI ticks
/// scale_enabled: returns 0-1
/// scale_root: returns 0-12 (0=C)
/// list_cnt: if viewing list view, returns event count
/// if setting_desc is unsupported, the function returns -1.
/// See MIDIEditor_SetSetting_int, MIDIEditor_GetActive, MIDIEditor_GetSetting_str
/// 
MIDIEditor_GetSetting_int: *fn (HWND midieditor, const *c_char setting_desc) callconv(.C) c_int;

/// MIDIEditor_GetSetting_str
/// Get settings from a MIDI editor. setting_desc can be:
/// last_clicked_cc_lane: returns text description ("velocity", "pitch", etc)
/// scale: returns the scale record, for example "102034050607" for a major scale
/// list_X: if viewing list view, returns string describing event at row X (0-based). String will have a list of key=value pairs, e.g. 'pos=4.0 len=4.0 offvel=127 msg=90317F'. pos/len times are in QN, len/offvel may not be present if event is not a note. other keys which may be present include pos_pq/len_pq, sel, mute, ccval14, ccshape, ccbeztension.
/// if setting_desc is unsupported, the function returns false.
/// See MIDIEditor_GetActive, MIDIEditor_GetSetting_int
/// 
MIDIEditor_GetSetting_str: *fn (HWND midieditor, const *c_char setting_desc, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// MIDIEditor_GetTake
/// get the take that is currently being edited in this MIDI editor. see MIDIEditor_EnumTakes
MIDIEditor_GetTake(HWND midieditor) callconv(.C) *MediaItem *fn_Take ; //TODO check me

/// MIDIEditor_LastFocused_OnCommand
/// Send an action command to the last focused MIDI editor. Returns false if there is no MIDI editor open, or if the view mode (piano roll or event list) does not match the input.
/// see MIDIEditor_OnCommand
MIDIEditor_LastFocused_OnCommand: *fn (c_int command_id, bool islistviewcommand) callconv(.C) bool;

/// MIDIEditor_OnCommand
/// Send an action command to a MIDI editor. Returns false if the supplied MIDI editor pointer is not valid (not an open MIDI editor).
/// see MIDIEditor_GetActive, MIDIEditor_LastFocused_OnCommand
MIDIEditor_OnCommand: *fn (HWND midieditor, c_int command_id) callconv(.C) bool;

/// MIDIEditor_SetSetting_int
/// Set settings for a MIDI editor. setting_desc can be:
/// active_note_row: 0-127
/// See MIDIEditor_GetSetting_int
/// 
MIDIEditor_SetSetting_int: *fn (HWND midieditor, const *c_char setting_desc, c_int setting) callconv(.C) bool;

/// MIDIEditorFlagsForTrack
/// Get or set MIDI editor settings for this track. pitchwheelrange: semitones up or down. flags &1: snap pitch lane edits to semitones if pitchwheel range is defined.
MIDIEditorFlagsForTrack: *fn (*MediaTrack track, *c_int pitchwheelrangeInOut, *c_int flagsInOut, bool is_set) callconv(.C) void;

/// mkpanstr
mkpanstr: *fn (*c_char strNeed64, double pan) callconv(.C) void;

/// mkvolpanstr
mkvolpanstr: *fn (*c_char strNeed64, double vol, double pan) callconv(.C) void;

/// mkvolstr
mkvolstr: *fn (*c_char strNeed64, double vol) callconv(.C) void;

/// MoveEditCursor
MoveEditCursor: *fn (double adjamt, bool dosel) callconv(.C) void;

/// MoveMediaItemToTrack
/// returns TRUE if move succeeded
MoveMediaItemToTrack: *fn (*MediaItem item, *MediaTrack desttr) callconv(.C) bool;

/// MuteAllTracks
MuteAllTracks: *fn (bool mute) callconv(.C) void;

/// my_getViewport
my_getViewport: *fn (*RECT r, const *RECT sr, bool wantWorkArea) callconv(.C) void;

/// NamedCommandLookup
/// Get the command ID number for named command that was registered by an extension such as "_SWS_ABOUT" or "_113088d11ae641c193a2b7ede3041ad5" for a ReaScript or a custom action.
NamedCommandLookup: *fn (const *c_char command_name) callconv(.C) c_int;

/// OnPauseButton
/// direct way to simulate pause button hit
OnPauseButton: *fn () callconv(.C) void;

/// OnPauseButtonEx
/// direct way to simulate pause button hit
OnPauseButtonEx: *fn (*ReaProject proj) callconv(.C) void;

/// OnPlayButton
/// direct way to simulate play button hit
OnPlayButton: *fn () callconv(.C) void;

/// OnPlayButtonEx
/// direct way to simulate play button hit
OnPlayButtonEx: *fn (*ReaProject proj) callconv(.C) void;

/// OnStopButton
/// direct way to simulate stop button hit
OnStopButton: *fn () callconv(.C) void;

/// OnStopButtonEx
/// direct way to simulate stop button hit
OnStopButtonEx: *fn (*ReaProject proj) callconv(.C) void;

/// OpenColorThemeFile
OpenColorThemeFile: *fn (const *c_char fn) callconv(.C) bool;

/// OpenMediaExplorer
/// Opens mediafn in the Media Explorer, play=true will play the file immediately (or toggle playback if mediafn was already open), =false will just select it.
OpenMediaExplorer: *fn (const *c_char mediafn, bool play) callconv(.C) HWND;

/// OscLocalMessageToHost
/// Send an OSC message directly to REAPER. The value argument may be NULL. The message will be matched against the default OSC patterns.
OscLocalMessageToHost: *fn (const *c_char message, const *double valueInOptional) callconv(.C) void;

/// parse_timestr
/// Parse hh:mm:ss.sss time string, return time in seconds (or 0.0 on error). See parse_timestr_pos, parse_timestr_len.
parse_timestr: *fn (const *c_char buf) callconv(.C) double;

/// parse_timestr_len
/// time formatting mode overrides: -1=proj default.
/// 0=time
/// 1=measures.beats + time
/// 2=measures.beats
/// 3=seconds
/// 4=samples
/// 5=h:m:s:f
/// 
parse_timestr_len: *fn (const *c_char buf, double offset, c_int modeoverride) callconv(.C) double;

/// parse_timestr_pos
/// Parse time string, time formatting mode overrides: -1=proj default.
/// 0=time
/// 1=measures.beats + time
/// 2=measures.beats
/// 3=seconds
/// 4=samples
/// 5=h:m:s:f
/// 
parse_timestr_pos: *fn (const *c_char buf, c_int modeoverride) callconv(.C) double;

/// parsepanstr
parsepanstr: *fn (const *c_char str) callconv(.C) double;

/// PCM_Sink_Create
PCM_Sink_Create(const *c_char filename, const *c_char cfg, c_int cfg_sz, c_int nch, c_int srate, bool buildpeaks) callconv(.C) *PCM *fn_sink ; //TODO check me

/// PCM_Sink_CreateEx
PCM_Sink_CreateEx(*ReaProject proj, const *c_char filename, const *c_char cfg, c_int cfg_sz, c_int nch, c_int srate, bool buildpeaks) callconv(.C) *PCM *fn_sink ; //TODO check me

/// PCM_Sink_CreateMIDIFile
PCM_Sink_CreateMIDIFile(const *c_char filename, const *c_char cfg, c_int cfg_sz, double bpm, c_int div) callconv(.C) *PCM *fn_sink ; //TODO check me

/// PCM_Sink_CreateMIDIFileEx
PCM_Sink_CreateMIDIFileEx(*ReaProject proj, const *c_char filename, const *c_char cfg, c_int cfg_sz, double bpm, c_int div) callconv(.C) *PCM *fn_sink ; //TODO check me

/// PCM_Sink_Enum
c_int PCM_Sink_Enum: *fn (c_int idx, const *c_char* descstrOut) callconv(.C) unsigned;

/// PCM_Sink_GetExtension
PCM_Sink_GetExtension: *fn (const *c_char data, c_int data_sz) callconv(.C) const *c_char ; //TODO check me

/// PCM_Sink_ShowConfig
PCM_Sink_ShowConfig: *fn (const *c_char cfg, c_int cfg_sz, HWND hwndParent) callconv(.C) HWND;

/// PCM_Source_BuildPeaks
/// Calls and returns PCM_source::PeaksBuild_Begin() if mode=0, PeaksBuild_Run() if mode=1, and PeaksBuild_Finish() if mode=2. Normal use is to call PCM_Source_BuildPeaks(src,0), and if that returns nonzero, call PCM_Source_BuildPeaks(src,1) periodically until it returns zero (it returns the percentage of the file remaining), then call PCM_Source_BuildPeaks(src,2) to finalize. If PCM_Source_BuildPeaks(src,0) returns zero, then no further action is necessary.
PCM_Source_BuildPeaks: *fn (*PCM_source src, c_int mode) callconv(.C) c_int;

/// PCM_Source_CreateFromFile
/// See PCM_Source_CreateFromFileEx.
PCM_Source_CreateFromFile(const *c_char filename) callconv(.C) *PCM *fn_source ; //TODO check me

/// PCM_Source_CreateFromFileEx
/// Create a PCM_source from filename, and override pref of MIDI files being imported as in-project MIDI events.
PCM_Source_CreateFromFileEx(const *c_char filename, bool forcenoMidiImp) callconv(.C) *PCM *fn_source ; //TODO check me

/// PCM_Source_CreateFromSimple
/// Creates a PCM_source from a ISimpleMediaDecoder
/// (if fn is non-null, it will open the file in dec)
PCM_Source_CreateFromSimple(*ISimpleMediaDecoder dec, const *c_char fn) callconv(.C) *PCM *fn_source ; //TODO check me

/// PCM_Source_CreateFromType
/// Create a PCM_source from a "type" (use this if you're going to load its state via LoadState/ProjectStateContext).
/// Valid types include "WAVE", "MIDI", or whatever plug-ins define as well.
PCM_Source_CreateFromType(const *c_char sourcetype) callconv(.C) *PCM *fn_source ; //TODO check me

/// PCM_Source_Destroy
/// Deletes a PCM_source -- be sure that you remove any project reference before deleting a source
PCM_Source_Destroy: *fn (*PCM_source src) callconv(.C) void;

/// PCM_Source_GetPeaks
/// Gets block of peak samples to buf. Note that the peak samples are interleaved, but in two or three blocks (maximums, then minimums, then extra). Return value has 20 bits of returned sample count, then 4 bits of output_mode (0xf00000), then a bit to signify whether extra_type was available (0x1000000). extra_type can be 115 ('s') for spectral information, which will return peak samples as integers with the low 15 bits frequency, next 14 bits tonality.
PCM_Source_GetPeaks: *fn (*PCM_source src, double peakrate, double starttime, c_int numchannels, c_int numsamplesperchannel, c_int want_extra_type, *double buf) callconv(.C) c_int;

/// PCM_Source_GetSectionInfo
/// If a section/reverse block, retrieves offset/len/reverse. return true if success
PCM_Source_GetSectionInfo: *fn (*PCM_source src, *double offsOut, *double lenOut, *bool revOut) callconv(.C) bool;

/// PeakBuild_Create
PeakBuild_Create(*PCM_source src, const *c_char fn, c_int srate, c_int nch) callconv(.C) *REAPER *fn_PeakBuild_Interface ; //TODO check me

/// PeakBuild_CreateEx
/// flags&1 for FP support
PeakBuild_CreateEx(*PCM_source src, const *c_char fn, c_int srate, c_int nch, c_int flags) callconv(.C) *REAPER *fn_PeakBuild_Interface ; //TODO check me

/// PeakGet_Create
PeakGet_Create(const *c_char fn, c_int srate, c_int nch) callconv(.C) *REAPER *fn_PeakGet_Interface ; //TODO check me

/// PitchShiftSubModeMenu
/// menu to select/modify pitch shifter submode, returns new value (or old value if no item selected)
PitchShiftSubModeMenu: *fn (HWND hwnd, c_int x, c_int y, c_int mode, c_int submode_sel) callconv(.C) c_int;

/// PlayPreview
/// return nonzero on success
PlayPreview: *fn (*preview_register_t preview) callconv(.C) c_int;

/// PlayPreviewEx
/// return nonzero on success. bufflags &1=buffer source, &2=treat length changes in source as varispeed and adjust internal state accordingly if buffering. measure_align<0=play immediately, >0=align playback with measure start
PlayPreviewEx: *fn (*preview_register_t preview, c_int bufflags, double measure_align) callconv(.C) c_int;

/// PlayTrackPreview
/// return nonzero on success,in these,m_out_chan is a track index (0-n)
PlayTrackPreview: *fn (*preview_register_t preview) callconv(.C) c_int;

/// PlayTrackPreview2
/// return nonzero on success,in these,m_out_chan is a track index (0-n)
PlayTrackPreview2: *fn (*ReaProject proj, *preview_register_t preview) callconv(.C) c_int;

/// PlayTrackPreview2Ex
/// return nonzero on success,in these,m_out_chan is a track index (0-n). see PlayPreviewEx
PlayTrackPreview2Ex: *fn (*ReaProject proj, *preview_register_t preview, c_int flags, double measure_align) callconv(.C) c_int;

/// plugin_getapi
plugin_getapi: *fn (const *c_char name) callconv(.C) *void;

/// plugin_getFilterList
/// Returns a double-NULL terminated list of importable media files, suitable for passing to GetOpenFileName() etc. Includes *.* (All files).
plugin_getFilterList: *fn () callconv(.C) const *c_char ; //TODO check me

/// plugin_getImportableProjectFilterList
/// Returns a double-NULL terminated list of importable project files, suitable for passing to GetOpenFileName() etc. Includes *.* (All files).
plugin_getImportableProjectFilterList: *fn () callconv(.C) const *c_char ; //TODO check me

/// plugin_register
/// Alias for reaper_plugin_info_t::Register, see reaper_plugin.h for documented uses.
plugin_register: *fn (const *c_char name, *void infostruct) callconv(.C) c_int;

/// PluginWantsAlwaysRunFx
PluginWantsAlwaysRunFx: *fn (c_int amt) callconv(.C) void;

/// PreventUIRefresh
/// adds prevent_count to the UI refresh prevention state; always add then remove the same amount, or major disfunction will occur
PreventUIRefresh: *fn (c_int prevent_count) callconv(.C) void;

/// projectconfig_var_addr
projectconfig_var_addr: *fn (*ReaProject proj, c_int idx) callconv(.C) *void;

/// projectconfig_var_getoffs
/// returns offset to pass to projectconfig_var_addr() to get project-config var of name. szout gets size of object. can also query "__metronome_ptr" query project metronome *PCM_source* offset
projectconfig_var_getoffs: *fn (const *c_char name, *c_int szOut) callconv(.C) c_int;

/// PromptForAction
/// Uses the action list to choose an action. Call with session_mode=1 to create a session (init_id will be the initial action to select, or 0), then poll with session_mode=0, checking return value for user-selected action (will return 0 if no action selected yet, or -1 if the action window is no longer available). When finished, call with session_mode=-1.
PromptForAction: *fn (c_int session_mode, c_int init_id, c_int section_id) callconv(.C) c_int;

/// realloc_cmd_clear
/// clears a buffer/buffer-size registration added with realloc_cmd_register_buf, and clears any later registrations, frees any allocated buffers. call after values are read from any registered pointers etc.
realloc_cmd_clear: *fn (c_int tok) callconv(.C) void;

/// realloc_cmd_ptr
/// special use for NeedBig script API functions - reallocates a NeedBig buffer and updates its size, returns false on error
realloc_cmd_ptr: *fn (*c_char* ptr, *c_int ptr_size, c_int new_size) callconv(.C) bool;

/// realloc_cmd_register_buf
/// registers a buffer/buffer-size which may be reallocated by an API (ptr/ptr_size will be updated to the new values). returns a token which should be passed to realloc_cmd_clear after API call and values are read.
realloc_cmd_register_buf: *fn (*c_char* ptr, *c_int ptr_size) callconv(.C) c_int;

/// ReaperGetPitchShiftAPI
/// version must be REAPER_PITCHSHIFT_API_VER
ReaperGetPitchShiftAPI: *fn (c_int version) callconv(.C) *IReaperPitchShift;

/// ReaScriptError
/// Causes REAPER to display the error message after the current ReaScript finishes. If called within a Lua context and errmsg has a ! prefix, script execution will be terminated.
ReaScriptError: *fn (const *c_char errmsg) callconv(.C) void;

/// RecursiveCreateDirectory
/// returns positive value on success, 0 on failure.
RecursiveCreateDirectory: *fn (const *c_char path, size_t ignored) callconv(.C) c_int;

/// reduce_open_files
/// garbage-collects extra open files and closes them. if flags has 1 set, this is done incrementally (call this from a regular timer, if desired). if flags has 2 set, files are aggressively closed (they may need to be re-opened very soon). returns number of files closed by this call.
reduce_open_files: *fn (c_int flags) callconv(.C) c_int;

/// RefreshToolbar
/// See RefreshToolbar2.
RefreshToolbar: *fn (c_int command_id) callconv(.C) void;

/// RefreshToolbar2
/// Refresh the toolbar button states of a toggle action.
RefreshToolbar2: *fn (c_int section_id, c_int command_id) callconv(.C) void;

/// relative_fn
/// Makes a filename "in" relative to the current project, if any.
relative_fn: *fn (const *c_char in, *c_char out, c_int out_sz) callconv(.C) void;

/// RemoveTrackSend
/// Remove a send/receive/hardware output, return true on success. category is <0 for receives, 0=sends, >0 for hardware outputs. See CreateTrackSend, GetSetTrackSendInfo, GetTrackSendInfo_Value, SetTrackSendInfo_Value, GetTrackNumSends.
RemoveTrackSend: *fn (*MediaTrack tr, c_int category, c_int sendidx) callconv(.C) bool;

/// RenderFileSection
/// Not available while playing back.
RenderFileSection: *fn (const *c_char source_filename, const *c_char target_filename, double start_percent, double end_percent, double playrate) callconv(.C) bool;

/// ReorderSelectedTracks
/// Moves all selected tracks to immediately above track specified by index beforeTrackIdx, returns false if no tracks were selected. makePrevFolder=0 for normal, 1 = as child of track preceding track specified by beforeTrackIdx, 2 = if track preceding track specified by beforeTrackIdx is last track in folder, extend folder
ReorderSelectedTracks: *fn (c_int beforeTrackIdx, c_int makePrevFolder) callconv(.C) bool;

/// Resample_EnumModes
Resample_EnumModes: *fn (c_int mode) callconv(.C) const *c_char ; //TODO check me

/// Resampler_Create
Resampler_Create() callconv(.C) *REAPER *fn_Resample_Interface ; //TODO check me

/// resolve_fn
/// See resolve_fn2.
resolve_fn: *fn (const *c_char in, *c_char out, c_int out_sz) callconv(.C) void;

/// resolve_fn2
/// Resolves a filename "in" by using project settings etc. If no file found, out will be a copy of in.
resolve_fn2: *fn (const *c_char in, *c_char out, c_int out_sz, const *c_char checkSubDirOptional) callconv(.C) void;

/// ResolveRenderPattern
/// Resolve a wildcard pattern into a set of nul-separated, double-nul terminated render target filenames. Returns the length of the string buffer needed for the returned file list. Call with path=NULL to suppress filtering out illegal pathnames, call with targets=NULL to get just the string buffer length.
ResolveRenderPattern: *fn (*ReaProject project, const *c_char path, const *c_char pattern, *c_char targets, c_int targets_sz) callconv(.C) c_int;

/// ReverseNamedCommandLookup
/// Get the named command for the given command ID. The returned string will not start with '_' (e.g. it will return "SWS_ABOUT"), it will be NULL if command_id is a native action.
ReverseNamedCommandLookup: *fn (c_int command_id) callconv(.C) const *c_char ; //TODO check me

/// ScaleFromEnvelopeMode
/// See GetEnvelopeScalingMode.
ScaleFromEnvelopeMode: *fn (c_int scaling_mode, double val) callconv(.C) double;

/// ScaleToEnvelopeMode
/// See GetEnvelopeScalingMode.
ScaleToEnvelopeMode: *fn (c_int scaling_mode, double val) callconv(.C) double;

/// screenset_register
screenset_register: *fn (*c_char id, *void callbackFunc, *void param) callconv(.C) void;

/// screenset_registerNew
screenset_registerNew: *fn (*c_char id, screensetNewCallbackFunc callbackFunc, *void param) callconv(.C) void;

/// screenset_unregister
screenset_unregister: *fn (*c_char id) callconv(.C) void;

/// screenset_unregisterByParam
screenset_unregisterByParam: *fn (*void param) callconv(.C) void;

/// screenset_updateLastFocus
screenset_updateLastFocus: *fn (HWND prevWin) callconv(.C) void;

/// SectionFromUniqueID
SectionFromUniqueID: *fn (c_int uniqueID) callconv(.C) *KbdSectionInfo;

/// SelectAllMediaItems
SelectAllMediaItems: *fn (*ReaProject proj, bool selected) callconv(.C) void;

/// SelectProjectInstance
SelectProjectInstance: *fn (*ReaProject proj) callconv(.C) void;

/// SendLocalOscMessage
/// Send an OSC message to REAPER. See CreateLocalOscHandler, DestroyLocalOscHandler.
SendLocalOscMessage: *fn (*void local_osc_handler, const *c_char msg, c_int msglen) callconv(.C) void;

/// SendMIDIMessageToHardware
/// Sends a MIDI message to output device specified by output. Message is sent in immediate mode. Lua example of how to pack the message string:
/// sysex = { 0xF0, 0x00, 0xF7 }
/// msg = ""
/// for i=1, #sysex do msg = msg .. string.c_char(sysex[i]) end
SendMIDIMessageToHardware: *fn (c_int output, const *c_char msg, c_int msg_sz) callconv(.C) void;

/// SetActiveTake
/// set this take active in this media item
SetActiveTake: *fn (*MediaItem_Take take) callconv(.C) void;

/// SetAutomationMode
/// sets all or selected tracks to mode.
SetAutomationMode: *fn (c_int mode, bool onlySel) callconv(.C) void;

/// SetCurrentBPM
/// set current BPM in project, set wantUndo=true to add undo point
SetCurrentBPM: *fn (*ReaProject __proj, double bpm, bool wantUndo) callconv(.C) void;

/// SetCursorContext
/// You must use this to change the focus programmatically. mode=0 to focus track panels, 1 to focus the arrange window, 2 to focus the arrange window and select env (or env==NULL to clear the current track/take envelope selection)
SetCursorContext: *fn (c_int mode, *TrackEnvelope envInOptional) callconv(.C) void;

/// SetEditCurPos
SetEditCurPos: *fn (double time, bool moveview, bool seekplay) callconv(.C) void;

/// SetEditCurPos2
SetEditCurPos2: *fn (*ReaProject proj, double time, bool moveview, bool seekplay) callconv(.C) void;

/// SetEnvelopePoint
/// Set attributes of an envelope point. Values that are not supplied will be ignored. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done. See SetEnvelopePointEx.
SetEnvelopePoint: *fn (*TrackEnvelope envelope, c_int ptidx, *double timeInOptional, *double valueInOptional, *c_int shapeInOptional, *double tensionInOptional, *bool selectedInOptional, *bool noSortInOptional) callconv(.C) bool;

/// SetEnvelopePointEx
/// Set attributes of an envelope point. Values that are not supplied will be ignored. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
/// autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
/// For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
/// even if the automation item is trimmed so that not all points are visible.
/// Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
/// See CountEnvelopePointsEx, GetEnvelopePointEx, InsertEnvelopePointEx, DeleteEnvelopePointEx.
SetEnvelopePointEx: *fn (*TrackEnvelope envelope, c_int autoitem_idx, c_int ptidx, *double timeInOptional, *double valueInOptional, *c_int shapeInOptional, *double tensionInOptional, *bool selectedInOptional, *bool noSortInOptional) callconv(.C) bool;

/// SetEnvelopeStateChunk
/// Sets the RPPXML state of an envelope, returns true if successful. Undo flag is a performance/caching hint.
SetEnvelopeStateChunk: *fn (*TrackEnvelope env, const *c_char str, bool isundoOptional) callconv(.C) bool;

/// SetExtState
/// Set the extended state value for a specific section and key. persist=true means the value should be stored and reloaded the next time REAPER is opened. See GetExtState, DeleteExtState, HasExtState.
SetExtState: *fn (const *c_char section, const *c_char key, const *c_char value, bool persist) callconv(.C) void;

/// SetGlobalAutomationOverride
/// mode: see GetGlobalAutomationOverride
SetGlobalAutomationOverride: *fn (c_int mode) callconv(.C) void;

/// SetItemStateChunk
/// Sets the RPPXML state of an item, returns true if successful. Undo flag is a performance/caching hint.
SetItemStateChunk: *fn (*MediaItem item, const *c_char str, bool isundoOptional) callconv(.C) bool;

/// SetMasterTrackVisibility
/// set &1 to show the master track in the TCP, &2 to HIDE in the mixer. Returns the previous visibility state. See GetMasterTrackVisibility.
SetMasterTrackVisibility: *fn (c_int flag) callconv(.C) c_int;

/// SetMediaItemInfo_Value
/// Set media item numerical-value attributes.
/// B_MUTE : bool * : muted (item solo overrides). setting this value will clear C_MUTE_SOLO.
/// B_MUTE_ACTUAL : bool * : muted (ignores solo). setting this value will not affect C_MUTE_SOLO.
/// C_LANEPLAYS : c_char * : in fixed lane tracks, 0=this item lane does not play, 1=this item lane plays exclusively, 2=this item lane plays and other lanes also play, -1=this item is on a non-visible, non-playing lane on a non-fixed-lane track (read-only)
/// C_MUTE_SOLO : c_char * : solo override (-1=soloed, 0=no override, 1=unsoloed). note that this API does not automatically unsolo other items when soloing (nor clear the unsolos when clearing the last soloed item), it must be done by the caller via action or via this API.
/// B_LOOPSRC : bool * : loop source
/// B_ALLTAKESPLAY : bool * : all takes play
/// B_UISEL : bool * : selected in arrange view
/// C_BEATATTACHMODE : c_char * : item timebase, -1=track or project default, 1=beats (position, length, rate), 2=beats (position only). for auto-stretch timebase: C_BEATATTACHMODE=1, C_AUTOSTRETCH=1
/// C_AUTOSTRETCH: : c_char * : auto-stretch at project tempo changes, 1=enabled, requires C_BEATATTACHMODE=1
/// C_LOCK : c_char * : locked, &1=locked
/// D_VOL : double * : item volume,  0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
/// D_POSITION : double * : item position in seconds
/// D_LENGTH : double * : item length in seconds
/// D_SNAPOFFSET : double * : item snap offset in seconds
/// D_FADEINLEN : double * : item manual fadein length in seconds
/// D_FADEOUTLEN : double * : item manual fadeout length in seconds
/// D_FADEINDIR : double * : item fadein curvature, -1..1
/// D_FADEOUTDIR : double * : item fadeout curvature, -1..1
/// D_FADEINLEN_AUTO : double * : item auto-fadein length in seconds, -1=no auto-fadein
/// D_FADEOUTLEN_AUTO : double * : item auto-fadeout length in seconds, -1=no auto-fadeout
/// C_FADEINSHAPE : c_int * : fadein shape, 0..6, 0=linear
/// C_FADEOUTSHAPE : c_int * : fadeout shape, 0..6, 0=linear
/// I_GROUPID : c_int * : group ID, 0=no group
/// I_LASTY : c_int * : Y-position (relative to top of track) in pixels (read-only)
/// I_LASTH : c_int * : height in pixels (read-only)
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// I_CURTAKE : c_int * : active take number
/// IP_ITEMNUMBER : c_int : item number on this track (read-only, returns the item number directly)
/// F_FREEMODE_Y : float * : free item positioning or fixed lane Y-position. 0=top of track, 1.0=bottom of track
/// F_FREEMODE_H : float * : free item positioning or fixed lane height. 0.5=half the track height, 1.0=full track height
/// I_FIXEDLANE : c_int * : fixed lane of item (fine to call with setNewValue, but returned value is read-only)
/// B_FIXEDLANE_HIDDEN : bool * : true if displaying only one fixed lane and this item is in a different lane (read-only)
/// 
SetMediaItemInfo_Value: *fn (*MediaItem item, const *c_char parmname, double newvalue) callconv(.C) bool;

/// SetMediaItemLength
/// Redraws the screen only if refreshUI == true.
/// See UpdateArrange().
SetMediaItemLength: *fn (*MediaItem item, double length, bool refreshUI) callconv(.C) bool;

/// SetMediaItemPosition
/// Redraws the screen only if refreshUI == true.
/// See UpdateArrange().
SetMediaItemPosition: *fn (*MediaItem item, double position, bool refreshUI) callconv(.C) bool;

/// SetMediaItemSelected
SetMediaItemSelected: *fn (*MediaItem item, bool selected) callconv(.C) void;

/// SetMediaItemTake_Source
/// Set media source of media item take. The old source will not be destroyed, it is the caller's responsibility to retrieve it and destroy it after. If source already exists in any project, it will be duplicated before being set. C/C++ code should not use this and instead use GetSetMediaItemTakeInfo() with P_SOURCE to manage ownership directly.
SetMediaItemTake_Source: *fn (*MediaItem_Take take, *PCM_source source) callconv(.C) bool;

/// SetMediaItemTakeInfo_Value
/// Set media item take numerical-value attributes.
/// D_STARTOFFS : double * : start offset in source media, in seconds
/// D_VOL : double * : take volume, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc, negative if take polarity is flipped
/// D_PAN : double * : take pan, -1..1
/// D_PANLAW : double * : take pan law, -1=default, 0.5=-6dB, 1.0=+0dB, etc
/// D_PLAYRATE : double * : take playback rate, 0.5=half speed, 1=normal, 2=double speed, etc
/// D_PITCH : double * : take pitch adjustment in semitones, -12=one octave down, 0=normal, +12=one octave up, etc
/// B_PPITCH : bool * : preserve pitch when changing playback rate
/// I_LASTY : c_int * : Y-position (relative to top of track) in pixels (read-only)
/// I_LASTH : c_int * : height in pixels (read-only)
/// I_CHANMODE : c_int * : channel mode, 0=normal, 1=reverse stereo, 2=downmix, 3=left, 4=right
/// I_PITCHMODE : c_int * : pitch shifter mode, -1=project default, otherwise high 2 bytes=shifter, low 2 bytes=parameter
/// I_STRETCHFLAGS : c_int * : stretch marker flags (&7 mask for mode override: 0=default, 1=balanced, 2/3/6=tonal, 4=transient, 5=no pre-echo)
/// F_STRETCHFADESIZE : float * : stretch marker fade size in seconds (0.0025 default)
/// I_RECPASSID : c_int * : record pass ID
/// I_TAKEFX_NCH : c_int * : number of internal audio channels for per-take FX to use (OK to call with setNewValue, but the returned value is read-only)
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// IP_TAKENUMBER : c_int : take number (read-only, returns the take number directly)
/// 
SetMediaItemTakeInfo_Value: *fn (*MediaItem_Take take, const *c_char parmname, double newvalue) callconv(.C) bool;

/// SetMediaTrackInfo_Value
/// Set track numerical-value attributes.
/// B_MUTE : bool * : muted
/// B_PHASE : bool * : track phase inverted
/// B_RECMON_IN_EFFECT : bool * : record monitoring in effect (current audio-thread playback state, read-only)
/// IP_TRACKNUMBER : c_int : track number 1-based, 0=not found, -1=master track (read-only, returns the c_int directly)
/// I_SOLO : c_int * : soloed, 0=not soloed, 1=soloed, 2=soloed in place, 5=safe soloed, 6=safe soloed in place
/// B_SOLO_DEFEAT : bool * : when set, if anything else is soloed and this track is not muted, this track acts soloed
/// I_FXEN : c_int * : fx enabled, 0=bypassed, !0=fx active
/// I_RECARM : c_int * : record armed, 0=not record armed, 1=record armed
/// I_RECINPUT : c_int * : record input, <0=no input. if 4096 set, input is MIDI and low 5 bits represent channel (0=all, 1-16=only chan), next 6 bits represent physical input (63=all, 62=VKB). If 4096 is not set, low 10 bits (0..1023) are input start channel (ReaRoute/Loopback start at 512). If 2048 is set, input is multichannel input (using track channel count), or if 1024 is set, input is stereo input, otherwise input is mono.
/// I_RECMODE : c_int * : record mode, 0=input, 1=stereo out, 2=none, 3=stereo out w/latency compensation, 4=midi output, 5=mono out, 6=mono out w/ latency compensation, 7=midi overdub, 8=midi replace
/// I_RECMODE_FLAGS : c_int * : record mode flags, &3=output recording mode (0=post fader, 1=pre-fx, 2=post-fx/pre-fader)
/// I_RECMON : c_int * : record monitoring, 0=off, 1=normal, 2=not when playing (tape style)
/// I_RECMONITEMS : c_int * : monitor items while recording, 0=off, 1=on
/// B_AUTO_RECARM : bool * : automatically set record arm when selected (does not immediately affect recarm state, script should set directly if desired)
/// I_VUMODE : c_int * : track vu mode, &1:disabled, &30==0:stereo peaks, &30==2:multichannel peaks, &30==4:stereo RMS, &30==8:combined RMS, &30==12:LUFS-M, &30==16:LUFS-S (readout=max), &30==20:LUFS-S (readout=current), &32:LUFS calculation on channels 1+2 only
/// I_AUTOMODE : c_int * : track automation mode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch
/// I_NCHAN : c_int * : number of track channels, 2-128, even numbers only
/// I_SELECTED : c_int * : track selected, 0=unselected, 1=selected
/// I_WNDH : c_int * : current TCP window height in pixels including envelopes (read-only)
/// I_TCPH : c_int * : current TCP window height in pixels not including envelopes (read-only)
/// I_TCPY : c_int * : current TCP window Y-position in pixels relative to top of arrange view (read-only)
/// I_MCPX : c_int * : current MCP X-position in pixels relative to mixer container (read-only)
/// I_MCPY : c_int * : current MCP Y-position in pixels relative to mixer container (read-only)
/// I_MCPW : c_int * : current MCP width in pixels (read-only)
/// I_MCPH : c_int * : current MCP height in pixels (read-only)
/// I_FOLDERDEPTH : c_int * : folder depth change, 0=normal, 1=track is a folder parent, -1=track is the last in the innermost folder, -2=track is the last in the innermost and next-innermost folders, etc
/// I_FOLDERCOMPACT : c_int * : folder collapsed state (only valid on folders), 0=normal, 1=collapsed, 2=fully collapsed
/// I_MIDIHWOUT : c_int * : track midi hardware output index, <0=disabled, low 5 bits are which channels (0=all, 1-16), next 5 bits are output device index (0-31)
/// I_MIDI_INPUT_CHANMAP : c_int * : -1 maps to source channel, otherwise 1-16 to map to MIDI channel
/// I_MIDI_CTL_CHAN : c_int * : -1 no link, 0-15 link to MIDI volume/pan on channel, 16 link to MIDI volume/pan on all channels
/// I_MIDI_TRACKSEL_FLAG : c_int * : MIDI editor track list options: &1=expand media items, &2=exclude from list, &4=auto-pruned
/// I_PERFFLAGS : c_int * : track performance flags, &1=no media buffering, &2=no anticipative FX
/// I_CUSTOMCOLOR : c_int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
/// I_HEIGHTOVERRIDE : c_int * : custom height override for TCP window, 0 for none, otherwise size in pixels
/// I_SPACER : c_int * : 1=TCP track spacer above this trackB_HEIGHTLOCK : bool * : track height lock (must set I_HEIGHTOVERRIDE before locking)
/// D_VOL : double * : trim volume of track, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
/// D_PAN : double * : trim pan of track, -1..1
/// D_WIDTH : double * : width of track, -1..1
/// D_DUALPANL : double * : dualpan position 1, -1..1, only if I_PANMODE==6
/// D_DUALPANR : double * : dualpan position 2, -1..1, only if I_PANMODE==6
/// I_PANMODE : c_int * : pan mode, 0=classic 3.x, 3=new balance, 5=stereo pan, 6=dual pan
/// D_PANLAW : double * : pan law of track, <0=project default, 0.5=-6dB, 0.707..=-3dB, 1=+0dB, 1.414..=-3dB with gain compensation, 2=-6dB with gain compensation, etc
/// I_PANLAW_FLAGS : c_int * : pan law flags, 0=sine taper, 1=hybrid taper with deprecated behavior when gain compensation enabled, 2=linear taper, 3=hybrid taper
/// P_ENV:<envchunkname or P_ENV:{GUID... : TrackEnvelope * : (read-only) chunkname can be <VOLENV, <PANENV, etc; GUID is the stringified envelope GUID.
/// B_SHOWINMIXER : bool * : track control panel visible in mixer (do not use on master track)
/// B_SHOWINTCP : bool * : track control panel visible in arrange view (do not use on master track)
/// B_MAINSEND : bool * : track sends audio to parent
/// C_MAINSEND_OFFS : c_char * : channel offset of track send to parent
/// C_MAINSEND_NCH : c_char * : channel count of track send to parent (0=use all child track channels, 1=use one channel only)
/// I_FREEMODE : c_int * : 1=track free item positioning enabled, 2=track fixed lanes enabled (call UpdateTimeline() after changing)
/// I_NUMFIXEDLANES : c_int * : number of track fixed lanes (fine to call with setNewValue, but returned value is read-only)
/// C_LANESCOLLAPSED : c_char * : fixed lane collapse state (1=lanes collapsed, 2=track displays as non-fixed-lanes but hidden lanes exist)
/// C_LANESETTINGS : c_char * : fixed lane settings (&1=auto-remove empty lanes at bottom, &2=do not auto-comp new recording, &4=newly recorded lanes play exclusively (else add lanes in layers), &8=big lanes (else small lanes), &16=add new recording at bottom (else record into first available lane), &32=hide lane buttons
/// C_LANEPLAYS:N : c_char * :  on fixed lane tracks, 0=lane N does not play, 1=lane N plays exclusively, 2=lane N plays and other lanes also play (fine to call with setNewValue, but returned value is read-only)
/// C_ALLLANESPLAY : c_char * : on fixed lane tracks, 0=no lanes play, 1=all lanes play, 2=some lanes play (fine to call with setNewValue 0 or 1, but returned value is read-only)
/// C_BEATATTACHMODE : c_char * : track timebase, -1=project default, 0=time, 1=beats (position, length, rate), 2=beats (position only)
/// F_MCP_FXSEND_SCALE : float * : scale of fx+send area in MCP (0=minimum allowed, 1=maximum allowed)
/// F_MCP_FXPARM_SCALE : float * : scale of fx parameter area in MCP (0=minimum allowed, 1=maximum allowed)
/// F_MCP_SENDRGN_SCALE : float * : scale of send area as proportion of the fx+send total area (0=minimum allowed, 1=maximum allowed)
/// F_TCP_FXPARM_SCALE : float * : scale of TCP parameter area when TCP FX are embedded (0=min allowed, default, 1=max allowed)
/// I_PLAY_OFFSET_FLAG : c_int * : track media playback offset state, &1=bypassed, &2=offset value is measured in samples (otherwise measured in seconds)
/// D_PLAY_OFFSET : double * : track media playback offset, units depend on I_PLAY_OFFSET_FLAG
/// 
SetMediaTrackInfo_Value: *fn (*MediaTrack tr, const *c_char parmname, double newvalue) callconv(.C) bool;

/// SetMIDIEditorGrid
/// Set the MIDI editor grid division. 0.25=quarter note, 1.0/3.0=half note tripet, etc.
SetMIDIEditorGrid: *fn (*ReaProject project, double division) callconv(.C) void;

/// SetMixerScroll
/// Scroll the mixer so that leftmosttrack is the leftmost visible track. Returns the leftmost track after scrolling, which may be different from the passed-in track if there are not enough tracks to its right.
SetMixerScroll: *fn (*MediaTrack leftmosttrack) callconv(.C) *MediaTrack;

/// SetMouseModifier
/// Set the mouse modifier assignment for a specific modifier key assignment, in a specific context.
/// Context is a string like "MM_CTX_ITEM" (see reaper-mouse.ini) or "Media item left drag" (unlocalized).
/// Modifier flag is a number from 0 to 15: add 1 for shift, 2 for control, 4 for alt, 8 for win.
/// (macOS: add 1 for shift, 2 for command, 4 for opt, 8 for control.)
/// For left-click and double-click contexts, the action can be any built-in command ID number
/// or any custom action ID string. Find built-in command IDs in the REAPER actions window
/// (enable "show command IDs" in the context menu), and find custom action ID strings in reaper-kb.ini.
/// The action string may be a mouse modifier ID (see reaper-mouse.ini) with " m" appended to it,
/// or (for click/double-click contexts) a command ID with " c" appended to it,
/// or the text that appears in the mouse modifiers preferences dialog, like "Move item" (unlocalized).
/// For example, SetMouseModifier("MM_CTX_ITEM", 0, "1 m") and SetMouseModifier("Media item left drag", 0, "Move item") are equivalent.
/// SetMouseModifier(context, modifier_flag, -1) will reset that mouse modifier to default.
/// SetMouseModifier(context, -1, -1) will reset the entire context to default.
/// SetMouseModifier(-1, -1, -1) will reset all contexts to default.
/// See GetMouseModifier.
/// 
SetMouseModifier: *fn (const *c_char context, c_int modifier_flag, const *c_char action) callconv(.C) void;

/// SetOnlyTrackSelected
/// Set exactly one track selected, deselect all others
SetOnlyTrackSelected: *fn (*MediaTrack track) callconv(.C) void;

/// SetProjectGrid
/// Set the arrange view grid division. 0.25=quarter note, 1.0/3.0=half note triplet, etc.
SetProjectGrid: *fn (*ReaProject project, double division) callconv(.C) void;

/// SetProjectMarker
/// Note: this function can't clear a marker's name (an empty string will leave the name unchanged), see SetProjectMarker4.
SetProjectMarker: *fn (c_int markrgnindexnumber, bool isrgn, double pos, double rgnend, const *c_char name) callconv(.C) bool;

/// SetProjectMarker2
/// Note: this function can't clear a marker's name (an empty string will leave the name unchanged), see SetProjectMarker4.
SetProjectMarker2: *fn (*ReaProject proj, c_int markrgnindexnumber, bool isrgn, double pos, double rgnend, const *c_char name) callconv(.C) bool;

/// SetProjectMarker3
/// Note: this function can't clear a marker's name (an empty string will leave the name unchanged), see SetProjectMarker4.
SetProjectMarker3: *fn (*ReaProject proj, c_int markrgnindexnumber, bool isrgn, double pos, double rgnend, const *c_char name, c_int color) callconv(.C) bool;

/// SetProjectMarker4
/// color should be 0 to not change, or ColorToNative(r,g,b)|0x1000000, flags&1 to clear name
SetProjectMarker4: *fn (*ReaProject proj, c_int markrgnindexnumber, bool isrgn, double pos, double rgnend, const *c_char name, c_int color, c_int flags) callconv(.C) bool;

/// SetProjectMarkerByIndex
/// See SetProjectMarkerByIndex2.
SetProjectMarkerByIndex: *fn (*ReaProject proj, c_int markrgnidx, bool isrgn, double pos, double rgnend, c_int IDnumber, const *c_char name, c_int color) callconv(.C) bool;

/// SetProjectMarkerByIndex2
/// Differs from SetProjectMarker4 in that markrgnidx is 0 for the first marker/region, 1 for the next, etc (see EnumProjectMarkers3), rather than representing the displayed marker/region ID number (see SetProjectMarker3). Function will fail if attempting to set a duplicate ID number for a region (duplicate ID numbers for markers are OK). , flags&1 to clear name. If flags&2, markers will not be re-sorted, and after making updates, you MUST call SetProjectMarkerByIndex2 with markrgnidx=-1 and flags&2 to force re-sort/UI updates.
SetProjectMarkerByIndex2: *fn (*ReaProject proj, c_int markrgnidx, bool isrgn, double pos, double rgnend, c_int IDnumber, const *c_char name, c_int color, c_int flags) callconv(.C) bool;

/// SetProjExtState
/// Save a key/value pair for a specific extension, to be restored the next time this specific project is loaded. Typically extname will be the name of a reascript or extension section. If key is NULL or "", all extended data for that extname will be deleted.  If val is NULL or "", the data previously associated with that key will be deleted. Returns the size of the state for this extname. See GetProjExtState, EnumProjExtState.
SetProjExtState: *fn (*ReaProject proj, const *c_char extname, const *c_char key, const *c_char value) callconv(.C) c_int;

/// SetRegionRenderMatrix
/// Add (flag > 0) or remove (flag < 0) a track from this region when using the region render matrix. If adding, flag==2 means force mono, flag==4 means force stereo, flag==N means force N/2 channels.
SetRegionRenderMatrix: *fn (*ReaProject proj, c_int regionindex, *MediaTrack track, c_int flag) callconv(.C) void;

/// SetRenderLastError
/// Used by pcmsink objects to set an error to display while creating the pcmsink object.
SetRenderLastError: *fn (const *c_char errorstr) callconv(.C) void;

/// SetTakeMarker
/// Inserts or updates a take marker. If idx<0, a take marker will be added, otherwise an existing take marker will be updated. Returns the index of the new or updated take marker (which may change if srcPos is updated). See GetNumTakeMarkers, GetTakeMarker, DeleteTakeMarker
SetTakeMarker: *fn (*MediaItem_Take take, c_int idx, const *c_char nameIn, *double srcposInOptional, *c_int colorInOptional) callconv(.C) c_int;

/// SetTakeStretchMarker
/// Adds or updates a stretch marker. If idx<0, stretch marker will be added. If idx>=0, stretch marker will be updated. When adding, if srcposInOptional is omitted, source position will be auto-calculated. When updating a stretch marker, if srcposInOptional is omitted, srcpos will not be modified. Position/srcposition values will be constrained to nearby stretch markers. Returns index of stretch marker, or -1 if did not insert (or marker already existed at time).
SetTakeStretchMarker: *fn (*MediaItem_Take take, c_int idx, double pos, const *double srcposInOptional) callconv(.C) c_int;

/// SetTakeStretchMarkerSlope
/// See GetTakeStretchMarkerSlope
SetTakeStretchMarkerSlope: *fn (*MediaItem_Take take, c_int idx, double slope) callconv(.C) bool;

/// SetTempoTimeSigMarker
/// Set parameters of a tempo/time signature marker. Provide either timepos (with measurepos=-1, beatpos=-1), or measurepos and beatpos (with timepos=-1). If timesig_num and timesig_denom are zero, the previous time signature will be used. ptidx=-1 will insert a new tempo/time signature marker. See CountTempoTimeSigMarkers, GetTempoTimeSigMarker, AddTempoTimeSigMarker.
SetTempoTimeSigMarker: *fn (*ReaProject proj, c_int ptidx, double timepos, c_int measurepos, double beatpos, double bpm, c_int timesig_num, c_int timesig_denom, bool lineartempo) callconv(.C) bool;

/// SetThemeColor
/// Temporarily updates the theme color to the color specified (or the theme default color if -1 is specified). Returns -1 on failure, otherwise returns the color (or transformed-color). Note that the UI is not updated by this, the caller should call UpdateArrange() etc as necessary. If the low bit of flags is set, any color transformations are bypassed. To read a value see GetThemeColor.
SetThemeColor: *fn (const *c_char ini_key, c_int color, c_int flagsOptional) callconv(.C) c_int;

/// SetToggleCommandState
/// Updates the toggle state of an action, returns true if succeeded. Only ReaScripts can have their toggle states changed programmatically. See RefreshToolbar2.
SetToggleCommandState: *fn (c_int section_id, c_int command_id, c_int state) callconv(.C) bool;

/// SetTrackAutomationMode
SetTrackAutomationMode: *fn (*MediaTrack tr, c_int mode) callconv(.C) void;

/// SetTrackColor
/// Set the custom track color, color is OS dependent (i.e. ColorToNative(r,g,b). To unset the track color, see SetMediaTrackInfo_Value I_CUSTOMCOLOR
SetTrackColor: *fn (*MediaTrack track, c_int color) callconv(.C) void;

/// SetTrackMIDILyrics
/// Set all MIDI lyrics on the track. Lyrics will be stuffed into any MIDI items found in range. Flag is unused at present. str is passed in as beat position, tab, text, tab (example with flag=2: "1.1.2\tLyric for measure 1 beat 2\t2.1.1\tLyric for measure 2 beat 1	"). See GetTrackMIDILyrics
SetTrackMIDILyrics: *fn (*MediaTrack track, c_int flag, const *c_char str) callconv(.C) bool;

/// SetTrackMIDINoteName
/// channel < 0 assigns these note names to all channels.
SetTrackMIDINoteName: *fn (c_int track, c_int pitch, c_int chan, const *c_char name) callconv(.C) bool;

/// SetTrackMIDINoteNameEx
/// channel < 0 assigns note name to all channels. pitch 128 assigns name for CC0, pitch 129 for CC1, etc.
SetTrackMIDINoteNameEx: *fn (*ReaProject proj, *MediaTrack track, c_int pitch, c_int chan, const *c_char name) callconv(.C) bool;

/// SetTrackSelected
SetTrackSelected: *fn (*MediaTrack track, bool selected) callconv(.C) void;

/// SetTrackSendInfo_Value
/// Set send/receive/hardware output numerical-value attributes, return true on success.
/// category is <0 for receives, 0=sends, >0 for hardware outputs
/// parameter names:
/// B_MUTE : bool *
/// B_PHASE : bool * : true to flip phase
/// B_MONO : bool *
/// D_VOL : double * : 1.0 = +0dB etc
/// D_PAN : double * : -1..+1
/// D_PANLAW : double * : 1.0=+0.0db, 0.5=-6dB, -1.0 = projdef etc
/// I_SENDMODE : c_int * : 0=post-fader, 1=pre-fx, 2=post-fx (deprecated), 3=post-fx
/// I_AUTOMODE : c_int * : automation mode (-1=use track automode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch)
/// I_SRCCHAN : c_int * : -1 for no audio send. Low 10 bits specify channel offset, and higher bits specify channel count. (srcchan>>10) == 0 for stereo, 1 for mono, 2 for 4 channel, 3 for 6 channel, etc.
/// I_DSTCHAN : c_int * : low 10 bits are destination index, &1024 set to mix to mono.
/// I_MIDIFLAGS : c_int * : low 5 bits=source channel 0=all, 1-16, 31=MIDI send disabled, next 5 bits=dest channel, 0=orig, 1-16=chan. &1024 for faders-send MIDI vol/pan. (>>14)&255 = src bus (0 for all, 1 for normal, 2+). (>>22)&255=destination bus (0 for all, 1 for normal, 2+)
/// See CreateTrackSend, RemoveTrackSend, GetTrackNumSends.
SetTrackSendInfo_Value: *fn (*MediaTrack tr, c_int category, c_int sendidx, const *c_char parmname, double newvalue) callconv(.C) bool;

/// SetTrackSendUIPan
/// send_idx<0 for receives, >=0 for hw ouputs, >=nb_of_hw_ouputs for sends. isend=1 for end of edit, -1 for an instant edit (such as reset), 0 for normal tweak.
SetTrackSendUIPan: *fn (*MediaTrack track, c_int send_idx, double pan, c_int isend) callconv(.C) bool;

/// SetTrackSendUIVol
/// send_idx<0 for receives, >=0 for hw ouputs, >=nb_of_hw_ouputs for sends. isend=1 for end of edit, -1 for an instant edit (such as reset), 0 for normal tweak.
SetTrackSendUIVol: *fn (*MediaTrack track, c_int send_idx, double vol, c_int isend) callconv(.C) bool;

/// SetTrackStateChunk
/// Sets the RPPXML state of a track, returns true if successful. Undo flag is a performance/caching hint.
SetTrackStateChunk: *fn (*MediaTrack track, const *c_char str, bool isundoOptional) callconv(.C) bool;

/// SetTrackUIInputMonitor
/// monitor: 0=no monitoring, 1=monitoring, 2=auto-monitoring. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUIInputMonitor: *fn (*MediaTrack track, c_int monitor, c_int igngroupflags) callconv(.C) c_int;

/// SetTrackUIMute
/// mute: <0 toggles, >0 sets mute, 0=unsets mute. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUIMute: *fn (*MediaTrack track, c_int mute, c_int igngroupflags) callconv(.C) c_int;

/// SetTrackUIPan
/// igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUIPan: *fn (*MediaTrack track, double pan, bool relative, bool done, c_int igngroupflags) callconv(.C) double;

/// SetTrackUIPolarity
/// polarity (AKA phase): <0 toggles, 0=normal, >0=inverted. returns new value or -1 if error.igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUIPolarity: *fn (*MediaTrack track, c_int polarity, c_int igngroupflags) callconv(.C) c_int;

/// SetTrackUIRecArm
/// recarm: <0 toggles, >0 sets recarm, 0=unsets recarm. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUIRecArm: *fn (*MediaTrack track, c_int recarm, c_int igngroupflags) callconv(.C) c_int;

/// SetTrackUISolo
/// solo: <0 toggles, 1 sets solo (default mode), 0=unsets solo, 2 sets solo (non-SIP), 4 sets solo (SIP). returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUISolo: *fn (*MediaTrack track, c_int solo, c_int igngroupflags) callconv(.C) c_int;

/// SetTrackUIVolume
/// igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUIVolume: *fn (*MediaTrack track, double volume, bool relative, bool done, c_int igngroupflags) callconv(.C) double;

/// SetTrackUIWidth
/// igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
SetTrackUIWidth: *fn (*MediaTrack track, double width, bool relative, bool done, c_int igngroupflags) callconv(.C) double;

/// ShowActionList
ShowActionList: *fn (*KbdSectionInfo section, HWND callerWnd) callconv(.C) void;

/// ShowConsoleMsg
/// Show a message to the user (also useful for debugging). Send "\n" for newline, "" to clear the console. Prefix string with "!SHOW:" and text will be added to console without opening the window. See ClearConsole
ShowConsoleMsg: *fn (const *c_char msg) callconv(.C) void;

/// ShowMessageBox
/// type 0=OK,1=OKCANCEL,2=ABORTRETRYIGNORE,3=YESNOCANCEL,4=YESNO,5=RETRYCANCEL : ret 1=OK,2=CANCEL,3=ABORT,4=RETRY,5=IGNORE,6=YES,7=NO
ShowMessageBox: *fn (const *c_char msg, const *c_char title, c_int type) callconv(.C) c_int;

/// ShowPopupMenu
/// shows a context menu, valid names include: track_input, track_panel, track_area, track_routing, item, ruler, envelope, envelope_point, envelope_item. ctxOptional can be a track pointer for *track_, item pointer for *item (but is optional). for envelope_point, ctx2Optional has point index, ctx3Optional has item index (0=main envelope, 1=first AI). for envelope_item, ctx2Optional has AI index (1=first AI)
ShowPopupMenu: *fn (const *c_char name, c_int x, c_int y, HWND hwndParentOptional, *void ctxOptional, c_int ctx2Optional, c_int ctx3Optional) callconv(.C) void;

/// SLIDER2DB
SLIDER2DB: *fn (double y) callconv(.C) double;

/// SnapToGrid
SnapToGrid: *fn (*ReaProject project, double time_pos) callconv(.C) double;

/// SoloAllTracks
/// solo=2 for SIP
SoloAllTracks: *fn (c_int solo) callconv(.C) void;

/// Splash_GetWnd
/// gets the splash window, in case you want to display a message over it. Returns NULL when the splash window is not displayed.
Splash_GetWnd: *fn () callconv(.C) HWND;

/// SplitMediaItem
/// the original item becomes the left-hand split, the function returns the right-hand split (or NULL if the split failed)
SplitMediaItem: *fn (*MediaItem item, double position) callconv(.C) *MediaItem;

/// StopPreview
/// return nonzero on success
StopPreview: *fn (*preview_register_t preview) callconv(.C) c_int;

/// StopTrackPreview
/// return nonzero on success
StopTrackPreview: *fn (*preview_register_t preview) callconv(.C) c_int;

/// StopTrackPreview2
/// return nonzero on success
StopTrackPreview2: *fn (*ReaProject proj, *preview_register_t preview) callconv(.C) c_int;

/// stringToGuid
stringToGuid: *fn (const *c_char str, *GUID g) callconv(.C) void;

/// StuffMIDIMessage
/// Stuffs a 3 byte MIDI message into either the Virtual MIDI Keyboard queue, or the MIDI-as-control input queue, or sends to a MIDI hardware output. mode=0 for VKB, 1 for control (actions map etc), 2 for VKB-on-current-channel; 16 for external MIDI device 0, 17 for external MIDI device 1, etc; see GetNumMIDIOutputs, GetMIDIOutputName.
StuffMIDIMessage: *fn (c_int mode, c_int msg1, c_int msg2, c_int msg3) callconv(.C) void;

/// TakeFX_AddByName
/// Adds or queries the position of a named FX in a take. See TrackFX_AddByName() for information on fxname and instantiate. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_AddByName: *fn (*MediaItem_Take take, const *c_char fxname, c_int instantiate) callconv(.C) c_int;

/// TakeFX_CopyToTake
/// Copies (or moves) FX from src_take to dest_take. Can be used with src_take=dest_take to reorder. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_CopyToTake: *fn (*MediaItem_Take src_take, c_int src_fx, *MediaItem_Take dest_take, c_int dest_fx, bool is_move) callconv(.C) void;

/// TakeFX_CopyToTrack
/// Copies (or moves) FX from src_take to dest_track. dest_fx can have 0x1000000 set to reference input FX. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_CopyToTrack: *fn (*MediaItem_Take src_take, c_int src_fx, *MediaTrack dest_track, c_int dest_fx, bool is_move) callconv(.C) void;

/// TakeFX_Delete
/// Remove a FX from take chain (returns true on success) FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_Delete: *fn (*MediaItem_Take take, c_int fx) callconv(.C) bool;

/// TakeFX_EndParamEdit
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_EndParamEdit: *fn (*MediaItem_Take take, c_int fx, c_int param) callconv(.C) bool;

/// TakeFX_FormatParamValue
/// Note: only works with FX that support Cockos VST extensions. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_FormatParamValue: *fn (*MediaItem_Take take, c_int fx, c_int param, double val, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TakeFX_FormatParamValueNormalized
/// Note: only works with FX that support Cockos VST extensions. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_FormatParamValueNormalized: *fn (*MediaItem_Take take, c_int fx, c_int param, double value, *c_char buf, c_int buf_sz) callconv(.C) bool;

/// TakeFX_GetChainVisible
/// returns index of effect visible in chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
TakeFX_GetChainVisible: *fn (*MediaItem_Take take) callconv(.C) c_int;

/// TakeFX_GetCount
TakeFX_GetCount: *fn (*MediaItem_Take take) callconv(.C) c_int;

/// TakeFX_GetEnabled
/// See TakeFX_SetEnabled FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetEnabled: *fn (*MediaItem_Take take, c_int fx) callconv(.C) bool;

/// TakeFX_GetEnvelope
/// Returns the FX parameter envelope. If the envelope does not exist and create=true, the envelope will be created. If the envelope already exists and is bypassed and create=true, then the envelope will be unbypassed. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetEnvelope: *fn (*MediaItem_Take take, c_int fxindex, c_int parameterindex, bool create) callconv(.C) *TrackEnvelope;

/// TakeFX_GetFloatingWindow
/// returns HWND of floating window for effect index, if any FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetFloatingWindow: *fn (*MediaItem_Take take, c_int index) callconv(.C) HWND;

/// TakeFX_GetFormattedParamValue
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetFormattedParamValue: *fn (*MediaItem_Take take, c_int fx, c_int param, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TakeFX_GetFXGUID
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetFXGUID: *fn (*MediaItem_Take take, c_int fx) callconv(.C) *GUID;

/// TakeFX_GetFXName
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetFXName: *fn (*MediaItem_Take take, c_int fx, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TakeFX_GetIOSize
/// Gets the number of input/output pins for FX if available, returns plug-in type or -1 on error FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetIOSize: *fn (*MediaItem_Take take, c_int fx, *c_int inputPinsOut, *c_int outputPinsOut) callconv(.C) c_int;

/// TakeFX_GetNamedConfigParm
/// gets plug-in specific named configuration value (returns true on success). see TrackFX_GetNamedConfigParm FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetNamedConfigParm: *fn (*MediaItem_Take take, c_int fx, const *c_char parmname, *c_char bufOutNeedBig, c_int bufOutNeedBig_sz) callconv(.C) bool;

/// TakeFX_GetNumParams
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetNumParams: *fn (*MediaItem_Take take, c_int fx) callconv(.C) c_int;

/// TakeFX_GetOffline
/// See TakeFX_SetOffline FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetOffline: *fn (*MediaItem_Take take, c_int fx) callconv(.C) bool;

/// TakeFX_GetOpen
/// Returns true if this FX UI is open in the FX chain window or a floating window. See TakeFX_SetOpen FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetOpen: *fn (*MediaItem_Take take, c_int fx) callconv(.C) bool;

/// TakeFX_GetParam
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetParam: *fn (*MediaItem_Take take, c_int fx, c_int param, *double minvalOut, *double maxvalOut) callconv(.C) double;

/// TakeFX_GetParameterStepSizes
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetParameterStepSizes: *fn (*MediaItem_Take take, c_int fx, c_int param, *double stepOut, *double smallstepOut, *double largestepOut, *bool istoggleOut) callconv(.C) bool;

/// TakeFX_GetParamEx
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetParamEx: *fn (*MediaItem_Take take, c_int fx, c_int param, *double minvalOut, *double maxvalOut, *double midvalOut) callconv(.C) double;

/// TakeFX_GetParamFromIdent
/// gets the parameter index from an identifying string (:wet, :bypass, or a string returned from GetParamIdent), or -1 if unknown. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetParamFromIdent: *fn (*MediaItem_Take take, c_int fx, const *c_char ident_str) callconv(.C) c_int;

/// TakeFX_GetParamIdent
/// gets an identifying string for the parameter FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetParamIdent: *fn (*MediaItem_Take take, c_int fx, c_int param, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TakeFX_GetParamName
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetParamName: *fn (*MediaItem_Take take, c_int fx, c_int param, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TakeFX_GetParamNormalized
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetParamNormalized: *fn (*MediaItem_Take take, c_int fx, c_int param) callconv(.C) double;

/// TakeFX_GetPinMappings
/// gets the effective channel mapping bitmask for a particular pin. high32Out will be set to the high 32 bits. Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetPinMappings: *fn (*MediaItem_Take take, c_int fx, c_int isoutput, c_int pin, *c_int high32Out) callconv(.C) c_int;

/// TakeFX_GetPreset
/// Get the name of the preset currently showing in the REAPER dropdown, or the full path to a factory preset file for VST3 plug-ins (.vstpreset). See TakeFX_SetPreset. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetPreset: *fn (*MediaItem_Take take, c_int fx, *c_char presetnameOut, c_int presetnameOut_sz) callconv(.C) bool;

/// TakeFX_GetPresetIndex
/// Returns current preset index, or -1 if error. numberOfPresetsOut will be set to total number of presets available. See TakeFX_SetPresetByIndex FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetPresetIndex: *fn (*MediaItem_Take take, c_int fx, *c_int numberOfPresetsOut) callconv(.C) c_int;

/// TakeFX_GetUserPresetFilename
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_GetUserPresetFilename: *fn (*MediaItem_Take take, c_int fx, *c_char fnOut, c_int fnOut_sz) callconv(.C) void;

/// TakeFX_NavigatePresets
/// presetmove==1 activates the next preset, presetmove==-1 activates the previous preset, etc. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_NavigatePresets: *fn (*MediaItem_Take take, c_int fx, c_int presetmove) callconv(.C) bool;

/// TakeFX_SetEnabled
/// See TakeFX_GetEnabled FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetEnabled: *fn (*MediaItem_Take take, c_int fx, bool enabled) callconv(.C) void;

/// TakeFX_SetNamedConfigParm
/// gets plug-in specific named configuration value (returns true on success). see TrackFX_SetNamedConfigParm FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetNamedConfigParm: *fn (*MediaItem_Take take, c_int fx, const *c_char parmname, const *c_char value) callconv(.C) bool;

/// TakeFX_SetOffline
/// See TakeFX_GetOffline FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetOffline: *fn (*MediaItem_Take take, c_int fx, bool offline) callconv(.C) void;

/// TakeFX_SetOpen
/// Open this FX UI. See TakeFX_GetOpen FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetOpen: *fn (*MediaItem_Take take, c_int fx, bool open) callconv(.C) void;

/// TakeFX_SetParam
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetParam: *fn (*MediaItem_Take take, c_int fx, c_int param, double val) callconv(.C) bool;

/// TakeFX_SetParamNormalized
///  FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetParamNormalized: *fn (*MediaItem_Take take, c_int fx, c_int param, double value) callconv(.C) bool;

/// TakeFX_SetPinMappings
/// sets the channel mapping bitmask for a particular pin. returns false if unsupported (not all types of plug-ins support this capability). Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetPinMappings: *fn (*MediaItem_Take take, c_int fx, c_int isoutput, c_int pin, c_int low32bits, c_int hi32bits) callconv(.C) bool;

/// TakeFX_SetPreset
/// Activate a preset with the name shown in the REAPER dropdown. Full paths to .vstpreset files are also supported for VST3 plug-ins. See TakeFX_GetPreset. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetPreset: *fn (*MediaItem_Take take, c_int fx, const *c_char presetname) callconv(.C) bool;

/// TakeFX_SetPresetByIndex
/// Sets the preset idx, or the factory preset (idx==-2), or the default user preset (idx==-1). Returns true on success. See TakeFX_GetPresetIndex. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_SetPresetByIndex: *fn (*MediaItem_Take take, c_int fx, c_int idx) callconv(.C) bool;

/// TakeFX_Show
/// showflag=0 for hidechain, =1 for show chain(index valid), =2 for hide floating window(index valid), =3 for show floating window (index valid) FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TakeFX_Show: *fn (*MediaItem_Take take, c_int index, c_int showFlag) callconv(.C) void;

/// TakeIsMIDI
/// Returns true if the active take contains MIDI.
TakeIsMIDI: *fn (*MediaItem_Take take) callconv(.C) bool;

/// ThemeLayout_GetLayout
/// Gets theme layout information. section can be 'global' for global layout override, 'seclist' to enumerate a list of layout sections, otherwise a layout section such as 'mcp', 'tcp', 'trans', etc. idx can be -1 to query the current value, -2 to get the description of the section (if not global), -3 will return the current context DPI-scaling (256=normal, 512=retina, etc), or 0..x. returns false if failed.
ThemeLayout_GetLayout: *fn (const *c_char section, c_int idx, *c_char nameOut, c_int nameOut_sz) callconv(.C) bool;

/// ThemeLayout_GetParameter
/// returns theme layout parameter. return value is cfg-name, or nil/empty if out of range.
ThemeLayout_GetParameter: *fn (c_int wp, const *c_char* descOutOptional, *c_int valueOutOptional, *c_int defValueOutOptional, *c_int minValueOutOptional, *c_int maxValueOutOptional) callconv(.C) const *c_char ; //TODO check me

/// ThemeLayout_RefreshAll
/// Refreshes all layouts
ThemeLayout_RefreshAll: *fn () callconv(.C) void;

/// ThemeLayout_SetLayout
/// Sets theme layout override for a particular section -- section can be 'global' or 'mcp' etc. If setting global layout, prefix a ! to the layout string to clear any per-layout overrides. Returns false if failed.
ThemeLayout_SetLayout: *fn (const *c_char section, const *c_char  layout) callconv(.C) bool;

/// ThemeLayout_SetParameter
/// sets theme layout parameter to value. persist=true in order to have change loaded on next theme load. note that the caller should update layouts via ??? to make changes visible.
ThemeLayout_SetParameter: *fn (c_int wp, c_int value, bool persist) callconv(.C) bool;

/// time_precise
/// Gets a precise system timestamp in seconds
time_precise: *fn () callconv(.C) double;

/// TimeMap2_beatsToTime
/// convert a beat position (or optionally a beats+measures if measures is non-NULL) to time.
TimeMap2_beatsToTime: *fn (*ReaProject proj, double tpos, const *c_int measuresInOptional) callconv(.C) double;

/// TimeMap2_GetDividedBpmAtTime
/// get the effective BPM at the time (seconds) position (i.e. 2x in /8 signatures)
TimeMap2_GetDividedBpmAtTime: *fn (*ReaProject proj, double time) callconv(.C) double;

/// TimeMap2_GetNextChangeTime
/// when does the next time map (tempo or time sig) change occur
TimeMap2_GetNextChangeTime: *fn (*ReaProject proj, double time) callconv(.C) double;

/// TimeMap2_QNToTime
/// converts project QN position to time.
TimeMap2_QNToTime: *fn (*ReaProject proj, double qn) callconv(.C) double;

/// TimeMap2_timeToBeats
/// convert a time into beats.
/// if measures is non-NULL, measures will be set to the measure count, return value will be beats since measure.
/// if cml is non-NULL, will be set to current measure length in beats (i.e. time signature numerator)
/// if fullbeats is non-NULL, and measures is non-NULL, fullbeats will get the full beat count (same value returned if measures is NULL).
/// if cdenom is non-NULL, will be set to the current time signature denominator.
TimeMap2_timeToBeats: *fn (*ReaProject proj, double tpos, *c_int measuresOutOptional, *c_int cmlOutOptional, *double fullbeatsOutOptional, *c_int cdenomOutOptional) callconv(.C) double;

/// TimeMap2_timeToQN
/// converts project time position to QN position.
TimeMap2_timeToQN: *fn (*ReaProject proj, double tpos) callconv(.C) double;

/// TimeMap_curFrameRate
/// Gets project framerate, and optionally whether it is drop-frame timecode
TimeMap_curFrameRate: *fn (*ReaProject proj, *bool dropFrameOut) callconv(.C) double;

/// TimeMap_GetDividedBpmAtTime
/// get the effective BPM at the time (seconds) position (i.e. 2x in /8 signatures)
TimeMap_GetDividedBpmAtTime: *fn (double time) callconv(.C) double;

/// TimeMap_GetMeasureInfo
/// Get the QN position and time signature information for the start of a measure. Return the time in seconds of the measure start.
TimeMap_GetMeasureInfo: *fn (*ReaProject proj, c_int measure, *double qn_startOut, *double qn_endOut, *c_int timesig_numOut, *c_int timesig_denomOut, *double tempoOut) callconv(.C) double;

/// TimeMap_GetMetronomePattern
/// Fills in a string representing the active metronome pattern. For example, in a 7/8 measure divided 3+4, the pattern might be "1221222". The length of the string is the time signature numerator, and the function returns the time signature denominator.
TimeMap_GetMetronomePattern: *fn (*ReaProject proj, double time, *c_char pattern, c_int pattern_sz) callconv(.C) c_int;

/// TimeMap_GetTimeSigAtTime
/// get the effective time signature and tempo
TimeMap_GetTimeSigAtTime: *fn (*ReaProject proj, double time, *c_int timesig_numOut, *c_int timesig_denomOut, *double tempoOut) callconv(.C) void;

/// TimeMap_QNToMeasures
/// Find which measure the given QN position falls in.
TimeMap_QNToMeasures: *fn (*ReaProject proj, double qn, *double qnMeasureStartOutOptional, *double qnMeasureEndOutOptional) callconv(.C) c_int;

/// TimeMap_QNToTime
/// converts project QN position to time.
TimeMap_QNToTime: *fn (double qn) callconv(.C) double;

/// TimeMap_QNToTime_abs
/// Converts project quarter note count (QN) to time. QN is counted from the start of the project, regardless of any partial measures. See TimeMap2_QNToTime
TimeMap_QNToTime_abs: *fn (*ReaProject proj, double qn) callconv(.C) double;

/// TimeMap_timeToQN
/// converts project QN position to time.
TimeMap_timeToQN: *fn (double tpos) callconv(.C) double;

/// TimeMap_timeToQN_abs
/// Converts project time position to quarter note count (QN). QN is counted from the start of the project, regardless of any partial measures. See TimeMap2_timeToQN
TimeMap_timeToQN_abs: *fn (*ReaProject proj, double tpos) callconv(.C) double;

/// ToggleTrackSendUIMute
/// send_idx<0 for receives, >=0 for hw ouputs, >=nb_of_hw_ouputs for sends.
ToggleTrackSendUIMute: *fn (*MediaTrack track, c_int send_idx) callconv(.C) bool;

/// Track_GetPeakHoldDB
/// Returns meter hold state, in *dB0.01 (0 = +0dB, -0.01 = -1dB, 0.02 = +2dB, etc). If clear is set, clears the meter hold. If channel==1024 or channel==1025, returns loudness values if this is the master track or this track's VU meters are set to display loudness.
Track_GetPeakHoldDB: *fn (*MediaTrack track, c_int channel, bool clear) callconv(.C) double;

/// Track_GetPeakInfo
/// Returns peak meter value (1.0=+0dB, 0.0=-inf) for channel. If channel==1024 or channel==1025, returns loudness values if this is the master track or this track's VU meters are set to display loudness.
Track_GetPeakInfo: *fn (*MediaTrack track, c_int channel) callconv(.C) double;

/// TrackCtl_SetToolTip
/// displays tooltip at location, or removes if empty string
TrackCtl_SetToolTip: *fn (const *c_char fmt, c_int xpos, c_int ypos, bool topmost) callconv(.C) void;

/// TrackFX_AddByName
/// Adds or queries the position of a named FX from the track FX chain (recFX=false) or record input FX/monitoring FX (recFX=true, monitoring FX are on master track). Specify a negative value for instantiate to always create a new effect, 0 to only query the first instance of an effect, or a positive value to add an instance if one is not found. If instantiate is <= -1000, it is used for the insertion position (-1000 is first item in chain, -1001 is second, etc). fxname can have prefix to specify type: VST3:,VST2:,VST:,AU:,JS:, or DX:, or FXADD: which adds selected items from the currently-open FX browser, FXADD:2 to limit to 2 FX added, or FXADD:2e to only succeed if exactly 2 FX are selected. Returns -1 on failure or the new position in chain on success. FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_AddByName: *fn (*MediaTrack track, const *c_char fxname, bool recFX, c_int instantiate) callconv(.C) c_int;

/// TrackFX_CopyToTake
/// Copies (or moves) FX from src_track to dest_take. src_fx can have 0x1000000 set to reference input FX. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_CopyToTake: *fn (*MediaTrack src_track, c_int src_fx, *MediaItem_Take dest_take, c_int dest_fx, bool is_move) callconv(.C) void;

/// TrackFX_CopyToTrack
/// Copies (or moves) FX from src_track to dest_track. Can be used with src_track=dest_track to reorder, FX indices have 0x1000000 set to reference input FX. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_CopyToTrack: *fn (*MediaTrack src_track, c_int src_fx, *MediaTrack dest_track, c_int dest_fx, bool is_move) callconv(.C) void;

/// TrackFX_Delete
/// Remove a FX from track chain (returns true on success) FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_Delete: *fn (*MediaTrack track, c_int fx) callconv(.C) bool;

/// TrackFX_EndParamEdit
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_EndParamEdit: *fn (*MediaTrack track, c_int fx, c_int param) callconv(.C) bool;

/// TrackFX_FormatParamValue
/// Note: only works with FX that support Cockos VST extensions. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_FormatParamValue: *fn (*MediaTrack track, c_int fx, c_int param, double val, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TrackFX_FormatParamValueNormalized
/// Note: only works with FX that support Cockos VST extensions. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_FormatParamValueNormalized: *fn (*MediaTrack track, c_int fx, c_int param, double value, *c_char buf, c_int buf_sz) callconv(.C) bool;

/// TrackFX_GetByName
/// Get the index of the first track FX insert that matches fxname. If the FX is not in the chain and instantiate is true, it will be inserted. See TrackFX_GetInstrument, TrackFX_GetEQ. Deprecated in favor of TrackFX_AddByName.
TrackFX_GetByName: *fn (*MediaTrack track, const *c_char fxname, bool instantiate) callconv(.C) c_int;

/// TrackFX_GetChainVisible
/// returns index of effect visible in chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
TrackFX_GetChainVisible: *fn (*MediaTrack track) callconv(.C) c_int;

/// TrackFX_GetCount
TrackFX_GetCount: *fn (*MediaTrack track) callconv(.C) c_int;

/// TrackFX_GetEnabled
/// See TrackFX_SetEnabled FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetEnabled: *fn (*MediaTrack track, c_int fx) callconv(.C) bool;

/// TrackFX_GetEQ
/// Get the index of ReaEQ in the track FX chain. If ReaEQ is not in the chain and instantiate is true, it will be inserted. See TrackFX_GetInstrument, TrackFX_GetByName.
TrackFX_GetEQ: *fn (*MediaTrack track, bool instantiate) callconv(.C) c_int;

/// TrackFX_GetEQBandEnabled
/// Returns true if the EQ band is enabled.
/// Returns false if the band is disabled, or if track/fxidx is not ReaEQ.
/// Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass.
/// Bandidx (ignored for master gain): 0=target first band matching bandtype, 1=target 2nd band matching bandtype, etc.
/// 
/// See TrackFX_GetEQ, TrackFX_GetEQParam, TrackFX_SetEQParam, TrackFX_SetEQBandEnabled. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetEQBandEnabled: *fn (*MediaTrack track, c_int fxidx, c_int bandtype, c_int bandidx) callconv(.C) bool;

/// TrackFX_GetEQParam
/// Returns false if track/fxidx is not ReaEQ.
/// Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass.
/// Bandidx (ignored for master gain): 0=target first band matching bandtype, 1=target 2nd band matching bandtype, etc.
/// Paramtype (ignored for master gain): 0=freq, 1=gain, 2=Q.
/// See TrackFX_GetEQ, TrackFX_SetEQParam, TrackFX_GetEQBandEnabled, TrackFX_SetEQBandEnabled. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetEQParam: *fn (*MediaTrack track, c_int fxidx, c_int paramidx, *c_int bandtypeOut, *c_int bandidxOut, *c_int paramtypeOut, *double normvalOut) callconv(.C) bool;

/// TrackFX_GetFloatingWindow
/// returns HWND of floating window for effect index, if any FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetFloatingWindow: *fn (*MediaTrack track, c_int index) callconv(.C) HWND;

/// TrackFX_GetFormattedParamValue
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetFormattedParamValue: *fn (*MediaTrack track, c_int fx, c_int param, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TrackFX_GetFXGUID
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetFXGUID: *fn (*MediaTrack track, c_int fx) callconv(.C) *GUID;

/// TrackFX_GetFXName
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetFXName: *fn (*MediaTrack track, c_int fx, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TrackFX_GetInstrument
/// Get the index of the first track FX insert that is a virtual instrument, or -1 if none. See TrackFX_GetEQ, TrackFX_GetByName.
TrackFX_GetInstrument: *fn (*MediaTrack track) callconv(.C) c_int;

/// TrackFX_GetIOSize
/// Gets the number of input/output pins for FX if available, returns plug-in type or -1 on error FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetIOSize: *fn (*MediaTrack track, c_int fx, *c_int inputPinsOut, *c_int outputPinsOut) callconv(.C) c_int;

/// TrackFX_GetNamedConfigParm
/// gets plug-in specific named configuration value (returns true on success). 
/// 
/// Supported values for read:
/// pdc : PDC latency
/// in_pin_X : name of input pin X
/// out_pin_X : name of output pin X
/// fx_type : type string
/// fx_ident : type-specific identifier
/// fx_name : name of FX (also supported as original_name)
/// GainReduction_dB : [ReaComp + other supported compressors]
/// parent_container : FX ID of parent container, if any (v7.06+)
/// container_count : [Container] number of FX in container
/// container_item.X : FX ID of item in container (first item is container_item.0) (v7.06+)
/// param.X.container_map.hint_id : unique ID of mapping (preserved if mapping order changes)
/// param.X.container_map.delete : read this value in order to remove the mapping for this parameter
/// container_map.add : read from this value to add a new container parameter mapping -- will return new parameter index (accessed via param.X.container_map.*)
/// container_map.add.FXID.PARMIDX : read from this value to add/get container parameter mapping for FXID/PARMIDX -- will return the parameter index (accessed via param.X.container_map.*). FXID can be a full address (must be a child of the container) or a 0-based sub-index (v7.06+).
/// container_map.get.FXID.PARMIDX : read from this value to get container parameter mapping for FXID/PARMIDX -- will return the parameter index (accessed via param.X.container_map.*). FXID can be a full address (must be a child of the container) or a 0-based sub-index (v7.06+).
/// 
/// 
/// Supported values for read/write:
/// vst_chunk[_program] : base64-encoded VST-specific chunk.
/// clap_chunk : base64-encoded CLAP-specific chunk.
/// param.X.lfo.[active,dir,phase,speed,strength,temposync,free,shape] : parameter moduation LFO state
/// param.X.acs.[active,dir,strength,attack,release,dblo,dbhi,chan,stereo,x2,y2] : parameter modulation ACS state
/// param.X.plink.[active,scale,offset,effect,param,midi_bus,midi_chan,midi_msg,midi_msg2] : parameter link/MIDI link: set effect=-100 to support *midi_
/// param.X.mod.[active,baseline,visible] : parameter module global settings
/// param.X.learn.[midi1,midi2,osc] : first two bytes of MIDI message, or OSC string if set
/// param.X.learn.mode : absolution/relative mode flag (0: Absolute, 1: 127=-1,1=+1, 2: 63=-1, 65=+1, 3: 65=-1, 1=+1, 4: toggle if nonzero)
/// param.X.learn.flags : &1=selected track only, &2=soft takeover, &4=focused FX only, &8=LFO retrigger, &16=visible FX only
/// param.X.container_map.fx_index : index of FX contained in container
/// param.X.container_map.fx_parm : parameter index of parameter of FX contained in container
/// param.X.container_map.aliased_name : name of parameter (if user-renamed, otherwise fails)
/// BANDTYPEx, BANDENABLEDx : band configuration [ReaEQ]
/// THRESHOLD, CEILING, TRUEPEAK : [ReaLimit]
/// NUMCHANNELS, NUMSPEAKERS, RESETCHANNELS : [ReaSurroundPan]
/// ITEMx : [ReaVerb] state configuration line, when writing should be followed by a write of DONE
/// FILE, FILEx, -FILEx, +FILEx, -*FILE : [RS5k] file list, -/+ prefixes are write-only, when writing any, should be followed by a write of DONE
/// MODE, RSMODE : [RS5k] general mode, resample mode
/// VIDEO_CODE : [video processor] code
/// force_auto_bypass : 0 or 1 - force auto-bypass plug-in on silence
/// parallel : 0, 1 or 2 - 1=process plug-in in parallel with previous, 2=process plug-in parallel and merge MIDI
/// instance_oversample_shift : instance oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
/// chain_oversample_shift : chain oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
/// chain_pdc_mode : chain PDC mode (0=classic, 1=new-default, 2=ignore PDC, 3=hwcomp-master)
/// chain_sel : selected/visible FX in chain
/// renamed_name : renamed FX instance name (empty string = not renamed)
/// container_nch : number of internal channels for container
/// container_nch_in : number of input pins for container
/// container_nch_out : number of output pints for container
/// container_nch_feedback : number of internal feedback channels enabled in container
/// focused : reading returns 1 if focused. Writing a positive value to this sets the FX UI as "last focused."
/// last_touched : reading returns two integers, one indicates whether FX is the last-touched FX, the second indicates which parameter was last touched. Writing a negative value ensures this plug-in is not set as last touched, otherwise the FX is set "last touched," and last touched parameter index is set to the value in the string (if valid).
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetNamedConfigParm: *fn (*MediaTrack track, c_int fx, const *c_char parmname, *c_char bufOutNeedBig, c_int bufOutNeedBig_sz) callconv(.C) bool;

/// TrackFX_GetNumParams
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetNumParams: *fn (*MediaTrack track, c_int fx) callconv(.C) c_int;

/// TrackFX_GetOffline
/// See TrackFX_SetOffline FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetOffline: *fn (*MediaTrack track, c_int fx) callconv(.C) bool;

/// TrackFX_GetOpen
/// Returns true if this FX UI is open in the FX chain window or a floating window. See TrackFX_SetOpen FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetOpen: *fn (*MediaTrack track, c_int fx) callconv(.C) bool;

/// TrackFX_GetParam
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetParam: *fn (*MediaTrack track, c_int fx, c_int param, *double minvalOut, *double maxvalOut) callconv(.C) double;

/// TrackFX_GetParameterStepSizes
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetParameterStepSizes: *fn (*MediaTrack track, c_int fx, c_int param, *double stepOut, *double smallstepOut, *double largestepOut, *bool istoggleOut) callconv(.C) bool;

/// TrackFX_GetParamEx
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetParamEx: *fn (*MediaTrack track, c_int fx, c_int param, *double minvalOut, *double maxvalOut, *double midvalOut) callconv(.C) double;

/// TrackFX_GetParamFromIdent
/// gets the parameter index from an identifying string (:wet, :bypass, :delta, or a string returned from GetParamIdent), or -1 if unknown. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetParamFromIdent: *fn (*MediaTrack track, c_int fx, const *c_char ident_str) callconv(.C) c_int;

/// TrackFX_GetParamIdent
/// gets an identifying string for the parameter FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetParamIdent: *fn (*MediaTrack track, c_int fx, c_int param, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TrackFX_GetParamName
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetParamName: *fn (*MediaTrack track, c_int fx, c_int param, *c_char bufOut, c_int bufOut_sz) callconv(.C) bool;

/// TrackFX_GetParamNormalized
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetParamNormalized: *fn (*MediaTrack track, c_int fx, c_int param) callconv(.C) double;

/// TrackFX_GetPinMappings
/// gets the effective channel mapping bitmask for a particular pin. high32Out will be set to the high 32 bits. Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetPinMappings: *fn (*MediaTrack tr, c_int fx, c_int isoutput, c_int pin, *c_int high32Out) callconv(.C) c_int;

/// TrackFX_GetPreset
/// Get the name of the preset currently showing in the REAPER dropdown, or the full path to a factory preset file for VST3 plug-ins (.vstpreset). See TrackFX_SetPreset. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetPreset: *fn (*MediaTrack track, c_int fx, *c_char presetnameOut, c_int presetnameOut_sz) callconv(.C) bool;

/// TrackFX_GetPresetIndex
/// Returns current preset index, or -1 if error. numberOfPresetsOut will be set to total number of presets available. See TrackFX_SetPresetByIndex FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetPresetIndex: *fn (*MediaTrack track, c_int fx, *c_int numberOfPresetsOut) callconv(.C) c_int;

/// TrackFX_GetRecChainVisible
/// returns index of effect visible in record input chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
TrackFX_GetRecChainVisible: *fn (*MediaTrack track) callconv(.C) c_int;

/// TrackFX_GetRecCount
/// returns count of record input FX. To access record input FX, use a FX indices [0x1000000..0x1000000+n). On the master track, this accesses monitoring FX rather than record input FX.
TrackFX_GetRecCount: *fn (*MediaTrack track) callconv(.C) c_int;

/// TrackFX_GetUserPresetFilename
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_GetUserPresetFilename: *fn (*MediaTrack track, c_int fx, *c_char fnOut, c_int fnOut_sz) callconv(.C) void;

/// TrackFX_NavigatePresets
/// presetmove==1 activates the next preset, presetmove==-1 activates the previous preset, etc. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_NavigatePresets: *fn (*MediaTrack track, c_int fx, c_int presetmove) callconv(.C) bool;

/// TrackFX_SetEnabled
/// See TrackFX_GetEnabled FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetEnabled: *fn (*MediaTrack track, c_int fx, bool enabled) callconv(.C) void;

/// TrackFX_SetEQBandEnabled
/// Enable or disable a ReaEQ band.
/// Returns false if track/fxidx is not ReaEQ.
/// Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass.
/// Bandidx (ignored for master gain): 0=target first band matching bandtype, 1=target 2nd band matching bandtype, etc.
/// 
/// See TrackFX_GetEQ, TrackFX_GetEQParam, TrackFX_SetEQParam, TrackFX_GetEQBandEnabled. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetEQBandEnabled: *fn (*MediaTrack track, c_int fxidx, c_int bandtype, c_int bandidx, bool enable) callconv(.C) bool;

/// TrackFX_SetEQParam
/// Returns false if track/fxidx is not ReaEQ. Targets a band matching bandtype.
/// Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass.
/// Bandidx (ignored for master gain): 0=target first band matching bandtype, 1=target 2nd band matching bandtype, etc.
/// Paramtype (ignored for master gain): 0=freq, 1=gain, 2=Q.
/// See TrackFX_GetEQ, TrackFX_GetEQParam, TrackFX_GetEQBandEnabled, TrackFX_SetEQBandEnabled. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetEQParam: *fn (*MediaTrack track, c_int fxidx, c_int bandtype, c_int bandidx, c_int paramtype, double val, bool isnorm) callconv(.C) bool;

/// TrackFX_SetNamedConfigParm
/// sets plug-in specific named configuration value (returns true on success).
/// 
/// Support values for write:
/// vst_chunk[_program] : base64-encoded VST-specific chunk.
/// clap_chunk : base64-encoded CLAP-specific chunk.
/// param.X.lfo.[active,dir,phase,speed,strength,temposync,free,shape] : parameter moduation LFO state
/// param.X.acs.[active,dir,strength,attack,release,dblo,dbhi,chan,stereo,x2,y2] : parameter modulation ACS state
/// param.X.plink.[active,scale,offset,effect,param,midi_bus,midi_chan,midi_msg,midi_msg2] : parameter link/MIDI link: set effect=-100 to support *midi_
/// param.X.mod.[active,baseline,visible] : parameter module global settings
/// param.X.learn.[midi1,midi2,osc] : first two bytes of MIDI message, or OSC string if set
/// param.X.learn.mode : absolution/relative mode flag (0: Absolute, 1: 127=-1,1=+1, 2: 63=-1, 65=+1, 3: 65=-1, 1=+1, 4: toggle if nonzero)
/// param.X.learn.flags : &1=selected track only, &2=soft takeover, &4=focused FX only, &8=LFO retrigger, &16=visible FX only
/// param.X.container_map.fx_index : index of FX contained in container
/// param.X.container_map.fx_parm : parameter index of parameter of FX contained in container
/// param.X.container_map.aliased_name : name of parameter (if user-renamed, otherwise fails)
/// BANDTYPEx, BANDENABLEDx : band configuration [ReaEQ]
/// THRESHOLD, CEILING, TRUEPEAK : [ReaLimit]
/// NUMCHANNELS, NUMSPEAKERS, RESETCHANNELS : [ReaSurroundPan]
/// ITEMx : [ReaVerb] state configuration line, when writing should be followed by a write of DONE
/// FILE, FILEx, -FILEx, +FILEx, -*FILE : [RS5k] file list, -/+ prefixes are write-only, when writing any, should be followed by a write of DONE
/// MODE, RSMODE : [RS5k] general mode, resample mode
/// VIDEO_CODE : [video processor] code
/// force_auto_bypass : 0 or 1 - force auto-bypass plug-in on silence
/// parallel : 0, 1 or 2 - 1=process plug-in in parallel with previous, 2=process plug-in parallel and merge MIDI
/// instance_oversample_shift : instance oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
/// chain_oversample_shift : chain oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
/// chain_pdc_mode : chain PDC mode (0=classic, 1=new-default, 2=ignore PDC, 3=hwcomp-master)
/// chain_sel : selected/visible FX in chain
/// renamed_name : renamed FX instance name (empty string = not renamed)
/// container_nch : number of internal channels for container
/// container_nch_in : number of input pins for container
/// container_nch_out : number of output pints for container
/// container_nch_feedback : number of internal feedback channels enabled in container
/// focused : reading returns 1 if focused. Writing a positive value to this sets the FX UI as "last focused."
/// last_touched : reading returns two integers, one indicates whether FX is the last-touched FX, the second indicates which parameter was last touched. Writing a negative value ensures this plug-in is not set as last touched, otherwise the FX is set "last touched," and last touched parameter index is set to the value in the string (if valid).
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetNamedConfigParm: *fn (*MediaTrack track, c_int fx, const *c_char parmname, const *c_char value) callconv(.C) bool;

/// TrackFX_SetOffline
/// See TrackFX_GetOffline FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetOffline: *fn (*MediaTrack track, c_int fx, bool offline) callconv(.C) void;

/// TrackFX_SetOpen
/// Open this FX UI. See TrackFX_GetOpen FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetOpen: *fn (*MediaTrack track, c_int fx, bool open) callconv(.C) void;

/// TrackFX_SetParam
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetParam: *fn (*MediaTrack track, c_int fx, c_int param, double val) callconv(.C) bool;

/// TrackFX_SetParamNormalized
///  FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetParamNormalized: *fn (*MediaTrack track, c_int fx, c_int param, double value) callconv(.C) bool;

/// TrackFX_SetPinMappings
/// sets the channel mapping bitmask for a particular pin. returns false if unsupported (not all types of plug-ins support this capability). Add 0x1000000 to pin index in order to access the second 64 bits of mappings independent of the first 64 bits. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetPinMappings: *fn (*MediaTrack tr, c_int fx, c_int isoutput, c_int pin, c_int low32bits, c_int hi32bits) callconv(.C) bool;

/// TrackFX_SetPreset
/// Activate a preset with the name shown in the REAPER dropdown. Full paths to .vstpreset files are also supported for VST3 plug-ins. See TrackFX_GetPreset. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetPreset: *fn (*MediaTrack track, c_int fx, const *c_char presetname) callconv(.C) bool;

/// TrackFX_SetPresetByIndex
/// Sets the preset idx, or the factory preset (idx==-2), or the default user preset (idx==-1). Returns true on success. See TrackFX_GetPresetIndex. FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_SetPresetByIndex: *fn (*MediaTrack track, c_int fx, c_int idx) callconv(.C) bool;

/// TrackFX_Show
/// showflag=0 for hidechain, =1 for show chain(index valid), =2 for hide floating window(index valid), =3 for show floating window (index valid) FX indices for tracks can have 0x1000000 added to them in order to reference record input FX (normal tracks) or hardware output FX (master track). FX indices can have 0x2000000 added to them, in which case they will be used to address FX in containers. To address a container, the 1-based subitem is multiplied by one plus the count of the FX chain and added to the 1-based container item index. e.g. to address the third item in the container at the second position of the track FX chain for tr, the index would be 0x2000000 + 3*(TrackFX_GetCount(tr)+1) + 2. This can be extended to sub-containers using TrackFX_GetNamedConfigParm with container_count and similar logic. In REAPER v7.06+, you can use the much more convenient method to navigate hierarchies, see TrackFX_GetNamedConfigParm with parent_container and container_item.X.
TrackFX_Show: *fn (*MediaTrack track, c_int index, c_int showFlag) callconv(.C) void;

/// TrackList_AdjustWindows
TrackList_AdjustWindows: *fn (bool isMinor) callconv(.C) void;

/// TrackList_UpdateAllExternalSurfaces
TrackList_UpdateAllExternalSurfaces: *fn () callconv(.C) void;

/// Undo_BeginBlock
/// call to start a new block
Undo_BeginBlock: *fn () callconv(.C) void;

/// Undo_BeginBlock2
/// call to start a new block
Undo_BeginBlock2: *fn (*ReaProject proj) callconv(.C) void;

/// Undo_CanRedo2
/// returns string of next action,if able,NULL if not
Undo_CanRedo2: *fn (*ReaProject proj) callconv(.C) const *c_char ; //TODO check me

/// Undo_CanUndo2
/// returns string of last action,if able,NULL if not
Undo_CanUndo2: *fn (*ReaProject proj) callconv(.C) const *c_char ; //TODO check me

/// Undo_DoRedo2
/// nonzero if success
Undo_DoRedo2: *fn (*ReaProject proj) callconv(.C) c_int;

/// Undo_DoUndo2
/// nonzero if success
Undo_DoUndo2: *fn (*ReaProject proj) callconv(.C) c_int;

/// Undo_EndBlock
/// call to end the block,with extra flags if any,and a description
Undo_EndBlock: *fn (const *c_char descchange, c_int extraflags) callconv(.C) void;

/// Undo_EndBlock2
/// call to end the block,with extra flags if any,and a description
Undo_EndBlock2: *fn (*ReaProject proj, const *c_char descchange, c_int extraflags) callconv(.C) void;

/// Undo_OnStateChange
/// limited state change to items
Undo_OnStateChange: *fn (const *c_char descchange) callconv(.C) void;

/// Undo_OnStateChange2
/// limited state change to items
Undo_OnStateChange2: *fn (*ReaProject proj, const *c_char descchange) callconv(.C) void;

/// Undo_OnStateChange_Item
Undo_OnStateChange_Item: *fn (*ReaProject proj, const *c_char name, *MediaItem item) callconv(.C) void;

/// Undo_OnStateChangeEx
/// trackparm=-1 by default,or if updating one fx chain,you can specify track index
Undo_OnStateChangeEx: *fn (const *c_char descchange, c_int whichStates, c_int trackparm) callconv(.C) void;

/// Undo_OnStateChangeEx2
/// trackparm=-1 by default,or if updating one fx chain,you can specify track index
Undo_OnStateChangeEx2: *fn (*ReaProject proj, const *c_char descchange, c_int whichStates, c_int trackparm) callconv(.C) void;

/// update_disk_counters
/// Updates disk I/O statistics with bytes transferred since last call. notify REAPER of a write error by calling with readamt=0, writeamt=-101010110 for unknown or -101010111 for disk full
update_disk_counters: *fn (c_int readamt, c_int writeamt) callconv(.C) void;

/// UpdateArrange
/// Redraw the arrange view
UpdateArrange: *fn () callconv(.C) void;

/// UpdateItemInProject
UpdateItemInProject: *fn (*MediaItem item) callconv(.C) void;

/// UpdateItemLanes
/// Recalculate lane arrangement for fixed lane tracks, including auto-removing empty lanes at the bottom of the track
UpdateItemLanes: *fn (*ReaProject proj) callconv(.C) bool;

/// UpdateTimeline
/// Redraw the arrange view and ruler
UpdateTimeline: *fn () callconv(.C) void;

/// ValidatePtr
/// see ValidatePtr2
ValidatePtr: *fn (*void pointer, const *c_char ctypename) callconv(.C) bool;

/// ValidatePtr2
/// Return true if the pointer is a valid object of the right type in proj (proj is ignored if pointer is itself a project). Supported types are: *ReaProject, *MediaTrack, *MediaItem, *MediaItem_Take, *TrackEnvelope and *PCM_source.
ValidatePtr2: *fn (*ReaProject proj, *void pointer, const *c_char ctypename) callconv(.C) bool;

/// ViewPrefs
/// Opens the prefs to a page, use pageByName if page is 0.
ViewPrefs: *fn (c_int page, const *c_char pageByName) callconv(.C) void;

/// WDL_VirtualWnd_ScaledBlitBG
WDL_VirtualWnd_ScaledBlitBG: *fn (*LICE_IBitmap dest, *WDL_VirtualWnd_BGCfg src, c_int destx, c_int desty, c_int destw, c_int desth, c_int clipx, c_int clipy, c_int clipw, c_int cliph, float alpha, c_int mode) callconv(.C) bool;

} = undefined;

