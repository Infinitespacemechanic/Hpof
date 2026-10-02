-- Snapshot.lean V10 - re-export V9 snapshot
import Snapshot

def isFrozenSnapshot (T : Int) (w : WaterType) : Bool := isFrozen T w
def brineOpenSnapshot (T : Int) : Bool := brineChannelOpen T
