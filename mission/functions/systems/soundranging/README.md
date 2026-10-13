# Sound Ranging

The server tracks functional `Land_vn_mobileradar_01_radar_f` buildables as sound-ranging towers. Black Horse engineers can also build a `vn_b_prop_vrc12` radio. The buildables are configured in Mike Force's `mission/config/subconfigs/buildables.hpp`. Their lifecycle callbacks follow Paradigm's building-feature pattern: entries in `server/configs/building_features.hpp` map to functions registered in `server/functions.hpp` and implemented in `server/functions/building_features/soundranging`.

When a supported static artillery object fires, the local owning machine installs a `Fired` event handler and forwards the firing source to the server. The server validates the source as supported enemy artillery, then checks each functional tower within 12 km and records the bearing from the tower to the shot. Detections are grouped within four seconds and expire after three minutes.

An alive Black Horse player within 5 m of a functional radio can request current bearings. The server sends the data only to that player. The player's client creates local orange bearing markers and installs a one-shot map-click handler while the map is open. A click confirms supported enemy artillery within 25 m with a local green marker; the handler is removed after the click or when the map closes.

Supported static artillery matches the OPFOR mortar and D-44 classnames used by the mission's artillery sites. East-side vehicles inheriting from `vn_howitzer_base`, as well as rocket-artillery classname variants, are also recognized.

The marker deletion handler intentionally ignores sound-ranging markers so MACV/SYSTIM alerts are not triggered for the system's own map overlays.
