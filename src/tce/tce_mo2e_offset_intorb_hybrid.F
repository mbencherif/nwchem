      SUBROUTINE tce_mo2e_offset_intorb_hybrid(l_a_offset,k_a_offset,
     1                                         size)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     v ( g3 g4 g1 g2 )_v
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
#include "tce_main.fh"
      INTEGER l_a_offset
      INTEGER k_a_offset
      INTEGER size
      INTEGER length
      INTEGER addr
      INTEGER g3b
      INTEGER g4b
      INTEGER g1b
      INTEGER g2b
      INTEGER IROW,ICOL,IRES
      INTEGER INDEX_PAIR
c
      length = 0
      DO g3b = 1,noa+nva   !j
      DO g4b = g3b,noa+nva !i
      DO g1b = 1,noa+nva   !l
      DO g2b = g1b,noa+nva !k
c
      if (.not.(g3b.gt.noa).and.(g4b.gt.noa).and.
     1         (g1b.gt.noa).and.(g2b.gt.noa)) then
c
      IF (int_mb(k_spin_alpha+g3b-1)+int_mb(k_spin_alpha+g4b-1).eq.
     &int_mb(k_spin_alpha+g1b-1)+int_mb(k_spin_alpha+g2b-1)) THEN
      IF (ieor(int_mb(k_sym_alpha+g3b-1),ieor(int_mb(k_sym_alpha+g4b-1),
     &    ieor(int_mb(k_sym_alpha+g1b-1),int_mb(k_sym_alpha+g2b-1))))
     &    .eq. irrep_v) THEN
      IROW=INDEX_PAIR(g4b,g3b)
      ICOL=INDEX_PAIR(g2b,g1b)
      IF(IROW.GE.ICOL) THEN       
      length = length + 1
      END IF
c
      endif
c
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
c
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('tce_mo2e_offset',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO g3b = 1,noa+nva   !j
      DO g4b = g3b,noa+nva !i
      DO g1b = 1,noa+nva   !l
      DO g2b = g1b,noa+nva !k
c
      if (.not.(g3b.gt.noa).and.(g4b.gt.noa).and.
     1         (g1b.gt.noa).and.(g2b.gt.noa)) then
c
      IF (int_mb(k_spin_alpha+g3b-1)+int_mb(k_spin_alpha+g4b-1).eq.
     &int_mb(k_spin_alpha+g1b-1)+int_mb(k_spin_alpha+g2b-1)) THEN
      IF (ieor(int_mb(k_sym_alpha+g3b-1),ieor(int_mb(k_sym_alpha+g4b-1),
     &ieor(int_mb(k_sym_alpha+g1b-1),int_mb(k_sym_alpha+g2b-1)))) .eq. 
     &irrep_v) THEN
      IROW=INDEX_PAIR(g4b,g3b)
      ICOL=INDEX_PAIR(g2b,g1b)
      IF(IROW.GE.ICOL) THEN
      addr = addr + 1
      IRES=INDEX_PAIR(IROW,ICOL)
      int_mb(k_a_offset+addr) = IRES
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range_alpha+g3b-1) * 
     &int_mb(k_range_alpha+g4b-1) * int_mb(k_range_alpha+g1b-1) * 
     &int_mb(k_range_alpha+g2b-1)
      END IF
c
      endif
c
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
