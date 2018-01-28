# The Five Minute Rule Twenty Years Later
- tl;dr
    - Flash sits between RAM and disk and can be used either as extended RAM or
      extended disk. File systems should view it as RAM and databases should
      view it as disk.
- Derivation of the Five Minute Rule
    - See https://github.com/mwhittaker/five_minute_rule
- Overview
    - The paper says that flash sits between RAM and disk and says that it can
      be viewed either as extended RAM or extended disk. It argues that file
      systems should use it as extended RAM and that databases should use it as
      extended disk.
    - Admittedly, this doesn't make much sense to me.
- Assumptions
    - The paper lists a bunch of assumptions, most of which don't seem too
      important.
- Five Minute Rules
    - If we compute new five minute rules for RAM/disk, RAM/flash, and
      flash/disk for 4 KB objects, we get 1.5 hours, 15 minutes, 2.5 hours.
    - Increasing the object size lowers the break even times.
- Page Movement
    - Both operating systems and databases move pages in similar ways.
-  Tracking Page Locations
    - Say a file system inserts a new file. It has to modify and write a lot of
      stuff like pointer pages. If it view flash as disk, it performs these
      writes to flash and eventually the writes are moved to disk. Thus, we
      have to double the amount of persistent writes.
    - A database simply logs stuff in a log, so it doesn't have to do many
      persistent writes, so treating flash as disk is ok.
- Checkpoints
    - Every so often, a database has to checkpoint stuff somewhere persistent.
      Using flash as a disk lets it write checkpoints faster. I'm not sure why
      this arugment doesn't also apply to file systems writing stuff to flash
      though?
    - An OS doesn't checkpoint, so it should treat flash as RAM.
- Page Size
    - With a disk, seek time dominates transfer time, so it's better to have
      bigger B+ tree nodes. With flash, seek time is less compared to transfer
      time, so we can shrink our B+ tree nodes a bit.
- Query Processing
    - With three levels in the memory hierarchy, we have to design level
      external sorts, hashing algorithms, etc.
    - Also, unclustered index joins might become faster than full table scans
      since the flash seek time is much lower.
