--  This file is covered by the Internet Software Consortium (ISC) License
--  Reference: ../License.txt

with Ada.Numerics.Discrete_Random;
with GNAT.String_Split;
with PortScan.Buildcycle.Pkgsrc;
with PortScan.Buildcycle.Ports;
with Replicant.Platform;
with Signals;
with Unix;

package body PortScan.Ops is

   package GSS renames GNAT.String_Split;
   package CYC renames PortScan.Buildcycle;
   package FPC renames PortScan.Buildcycle.Ports;
   package NPS renames PortScan.Buildcycle.Pkgsrc;
   package REP renames Replicant;
   package SIG renames Signals;


   --------------------------
   --  initialize_display  --
   --------------------------
   procedure initialize_display (num_builders : builders) is
   begin
      if PM.configuration.avec_ncurses then
         curses_support := DPY.launch_monitor (num_builders);
      end if;
   end initialize_display;


   -------------------------
   --  parallel_bulk_run  --
   -------------------------
   procedure parallel_bulk_run (num_builders : builders; logs : dim_handlers)
   is
      subtype cycle_count   is Natural range 1 .. 9;
      subtype refresh_count is Natural range 1 .. 4;
      subtype www_count     is Natural range 1 .. 3;
      subtype alert_count   is Natural range 1 .. 200;
      instructions   : dim_instruction   := (others => port_match_failed);
      builder_states : dim_builder_state := (others => idle);
      cntcycle       : cycle_count       := cycle_count'First;
      cntrefresh     : refresh_count     := refresh_count'First;
      cntalert       : alert_count       := alert_count'First;
      cntwww         : www_count         := www_count'First;
      run_complete   : Boolean           := False;
      available      : Positive          := Integer (num_builders);
      target         : port_id;
      all_idle       : Boolean;
      cntskip        : Natural;
      sumdata        : DPY.summary_rec;

      task type build (builder : builders);
      task body build
      is
         type Rand_Draw is range 1 .. 20;
         package Rand20 is new Ada.Numerics.Discrete_Random (Rand_Draw);
         seed : Rand20.Generator;
         build_result : Boolean;
         opts : REP.slave_options;
      begin
         if builder <= num_builders then
            if not curses_support then
               TIO.Put_Line (CYC.elapsed_now & " => [" &
                               JT.zeropad (Integer (builder), 2) &
                               "] Builder launched");
            end if;
            loop
               exit when builder_states (builder) = shutdown;
               if builder_states (builder) = tasked then
                  builder_states (builder) := busy;
                  opts.need_procfs :=
                    all_ports (instructions (builder)).use_procfs;
                  opts.need_linprocfs :=
                    all_ports (instructions (builder)).use_linprocfs;

                  REP.launch_slave (id => builder, opts => opts);
                  case software_framework is
                     when ports_collection =>
                        build_result :=
                          FPC.build_package (builder, instructions (builder));
                     when pkgsrc =>
                        if not REP.Platform.standalone_pkg8_install (builder)
                        then
                           build_result := False;
                        else
                           build_result := NPS.build_package
                             (builder, instructions (builder));
                        end if;
                  end case;
                  REP.destroy_slave (id => builder, opts => opts);
                  if build_result then
                     builder_states (builder) := done_success;
                  else
                     builder_states (builder) := done_failure;
                  end if;
               else
                  --  idle or done-(failure|success), just wait a bit
                  delay 0.1;
               end if;
            end loop;
            if not curses_support then
               TIO.Put_Line (CYC.elapsed_now & " => [" &
                               JT.zeropad (Integer (builder), 2) &
                               "]          Shutting down");
            end if;
         end if;
      end build;

      builder_01 : build (builder => 1);
      builder_02 : build (builder => 2);
      builder_03 : build (builder => 3);
      builder_04 : build (builder => 4);
      builder_05 : build (builder => 5);
      builder_06 : build (builder => 6);
      builder_07 : build (builder => 7);
      builder_08 : build (builder => 8);
      builder_09 : build (builder => 9);
      builder_10 : build (builder => 10);
      builder_11 : build (builder => 11);
      builder_12 : build (builder => 12);
      builder_13 : build (builder => 13);
      builder_14 : build (builder => 14);
      builder_15 : build (builder => 15);
      builder_16 : build (builder => 16);
      builder_17 : build (builder => 17);
      builder_18 : build (builder => 18);
      builder_19 : build (builder => 19);
      builder_20 : build (builder => 20);
      builder_21 : build (builder => 21);
      builder_22 : build (builder => 22);
      builder_23 : build (builder => 23);
      builder_24 : build (builder => 24);
      builder_25 : build (builder => 25);
      builder_26 : build (builder => 26);
      builder_27 : build (builder => 27);
      builder_28 : build (builder => 28);
      builder_29 : build (builder => 29);
      builder_30 : build (builder => 30);
      builder_31 : build (builder => 31);
      builder_32 : build (builder => 32);
      builder_33 : build (builder => 33);
      builder_34 : build (builder => 34);
      builder_35 : build (builder => 35);
      builder_36 : build (builder => 36);
      builder_37 : build (builder => 37);
      builder_38 : build (builder => 38);
      builder_39 : build (builder => 39);
      builder_40 : build (builder => 40);
      builder_41 : build (builder => 41);
      builder_42 : build (builder => 42);
      builder_43 : build (builder => 43);
      builder_44 : build (builder => 44);
      builder_45 : build (builder => 45);
      builder_46 : build (builder => 46);
      builder_47 : build (builder => 47);
      builder_48 : build (builder => 48);
      builder_49 : build (builder => 49);
      builder_50 : build (builder => 50);
      builder_51 : build (builder => 51);
      builder_52 : build (builder => 52);
      builder_53 : build (builder => 53);
      builder_54 : build (builder => 54);
      builder_55 : build (builder => 55);
      builder_56 : build (builder => 56);
      builder_57 : build (builder => 57);
      builder_58 : build (builder => 58);
      builder_59 : build (builder => 59);
      builder_60 : build (builder => 60);
      builder_61 : build (builder => 61);
      builder_62 : build (builder => 62);
      builder_63 : build (builder => 63);
      builder_64 : build (builder => 64);

      --  Expansion of cpu_range from 32 to 64 means 128 possible builders
      builder_65  : build (builder => 65);
      builder_66  : build (builder => 66);
      builder_67  : build (builder => 67);
      builder_68  : build (builder => 68);
      builder_69  : build (builder => 69);
      builder_70  : build (builder => 70);
      builder_71  : build (builder => 71);
      builder_72  : build (builder => 72);
      builder_73  : build (builder => 73);
      builder_74  : build (builder => 74);
      builder_75  : build (builder => 75);
      builder_76  : build (builder => 76);
      builder_77  : build (builder => 77);
      builder_78  : build (builder => 78);
      builder_79  : build (builder => 79);
      builder_80  : build (builder => 80);
      builder_81  : build (builder => 81);
      builder_82  : build (builder => 82);
      builder_83  : build (builder => 83);
      builder_84  : build (builder => 84);
      builder_85  : build (builder => 85);
      builder_86  : build (builder => 86);
      builder_87  : build (builder => 87);
      builder_88  : build (builder => 88);
      builder_89  : build (builder => 89);
      builder_90  : build (builder => 90);
      builder_91  : build (builder => 91);
      builder_92  : build (builder => 92);
      builder_93  : build (builder => 93);
      builder_94  : build (builder => 94);
      builder_95  : build (builder => 95);
      builder_96  : build (builder => 96);
      builder_97  : build (builder => 97);
      builder_98  : build (builder => 98);
      builder_99  : build (builder => 99);
      builder_100 : build (builder => 100);
      builder_101 : build (builder => 101);
      builder_102 : build (builder => 102);
      builder_103 : build (builder => 103);
      builder_104 : build (builder => 104);
      builder_105 : build (builder => 105);
      builder_106 : build (builder => 106);
      builder_107 : build (builder => 107);
      builder_108 : build (builder => 108);
      builder_109 : build (builder => 109);
      builder_110 : build (builder => 110);
      builder_111 : build (builder => 111);
      builder_112 : build (builder => 112);
      builder_113 : build (builder => 113);
      builder_114 : build (builder => 114);
      builder_115 : build (builder => 115);
      builder_116 : build (builder => 116);
      builder_117 : build (builder => 117);
      builder_118 : build (builder => 118);
      builder_119 : build (builder => 119);
      builder_120 : build (builder => 120);
      builder_121 : build (builder => 121);
      builder_122 : build (builder => 122);
      builder_123 : build (builder => 123);
      builder_124 : build (builder => 124);
      builder_125 : build (builder => 125);
      builder_126 : build (builder => 126);
      builder_127 : build (builder => 127);
      builder_128 : build (builder => 128);

   begin
      loop
         all_idle := True;
         for slave in 1 .. num_builders loop
            declare
            begin
               case builder_states (slave) is
               when busy | tasked =>
                  all_idle := False;
               when shutdown =>
                  null;
               when idle =>
                  if run_complete then
                     builder_states (slave) := shutdown;
                  else
                     target := top_buildable_port;
                     if target = port_match_failed then
                        if SIG.graceful_shutdown_requested or else
                          nothing_left (num_builders)
                        then
                           run_complete := True;
                           builder_states (slave) := shutdown;
                           DPY.insert_history (assemble_HR (slave, 0,
                                               DPY.action_shutdown));
                        else
                           if shutdown_recommended (available) then
                              builder_states (slave) := shutdown;
                              DPY.insert_history (assemble_HR (slave, 0,
                                                  DPY.action_shutdown));
                              available := available - 1;
                           end if;
                        end if;
                     else
                        lock_package (target);
                        instructions (slave) := target;
                        builder_states (slave) := tasked;
                        TIO.Put_Line (logs (total), CYC.elapsed_now & " [" &
                                     JT.zeropad (Integer (slave), 2) & "] => " &
                                        port_name (instructions (slave)));
                        if not curses_support then
                           TIO.Put_Line (CYC.elapsed_now & " => [" &
                                           JT.zeropad (Integer (slave), 2) &
                                           "]          Kickoff " &
                                           port_name (instructions (slave)));
                        end if;
                     end if;
                  end if;
               when done_success | done_failure =>
                  all_idle := False;
                  if builder_states (slave) = done_success then
                     if curses_support then
                        DPY.insert_history
                          (assemble_HR (slave, instructions (slave),
                           DPY.action_success));
                     else
                        TIO.Put_Line (CYC.elapsed_now & " => [" &
                                        JT.zeropad (Integer (slave), 2) &
                                        "] " & CYC.elapsed_build (slave) &
                                        " Success " &
                                        port_name (instructions (slave)));
                     end if;
                     record_history_built (elapsed   => CYC.elapsed_now,
                                           slave_id  => slave,
                                           origin    => port_name (instructions (slave)),
                                           duration  => CYC.elapsed_build (slave));
                     run_package_hook (pkg_success, instructions (slave));
                     cascade_successful_build (instructions (slave));
                     bld_counter (success) := bld_counter (success) + 1;
                     TIO.Put_Line (logs (success), CYC.elapsed_now & " " &
                                     port_name (instructions (slave)));
                     TIO.Put_Line (logs (total), CYC.elapsed_now & " " &
                                     port_name (instructions (slave)) &
                                     " success");
                  else
                     TIO.Put_Line (logs (total), CYC.elapsed_now & " " &
                                     port_name (instructions (slave)) &
                                     " FAILED!");
                     cascade_failed_build (instructions (slave), cntskip, logs);
                     bld_counter (skipped) := bld_counter (skipped) + cntskip;
                     bld_counter (failure) := bld_counter (failure) + 1;
                     TIO.Put_Line (logs (total), CYC.elapsed_now & " " &
                                     port_name (instructions (slave)) &
                                     " failure skips:" & JT.int2str (cntskip));
                     TIO.Put_Line (logs (failure), CYC.elapsed_now & " " &
                                     port_name (instructions (slave)) &
                                     " (skipped" & cntskip'Img & ")");
                     if curses_support then
                        DPY.insert_history
                          (assemble_HR (slave, instructions (slave),
                           DPY.action_failure));
                     else
                        TIO.Put_Line (CYC.elapsed_now & " => [" &
                                        JT.zeropad (Integer (slave), 2) &
                                        "] " & CYC.elapsed_build (slave) &
                                        " Failure " &
                                        port_name (instructions (slave)));
                     end if;
                     case software_framework is
                        when ports_collection =>
                           record_history_failed
                             (elapsed   => CYC.elapsed_now,
                              slave_id  => slave,
                              origin    => port_name (instructions (slave)),
                              duration  => CYC.elapsed_build (slave),
                              die_phase => FPC.last_build_phase (slave),
                              skips     => cntskip);
                        when pkgsrc =>
                           record_history_failed
                             (elapsed   => CYC.elapsed_now,
                              slave_id  => slave,
                              origin    => port_name (instructions (slave)),
                              duration  => CYC.elapsed_build (slave),
                              die_phase => NPS.last_build_phase (slave),
                              skips     => cntskip);
                     end case;
                     run_package_hook (pkg_failure, instructions (slave));
                  end if;
                  instructions (slave) := port_match_failed;
                  if run_complete then
                     builder_states (slave) := shutdown;
                     DPY.insert_history (assemble_HR (slave, 0,
                                         DPY.action_shutdown));
                  else
                     builder_states (slave) := idle;
                  end if;
               end case;
            exception
               when earthquake : others => TIO.Put_Line
                    (logs (total), CYC.elapsed_now & " UNHANDLED EXCEPTION: " &
                       EX.Exception_Information (earthquake));
            end;
         end loop;
         exit when run_complete and all_idle;
         if cntcycle = cycle_count'Last then
            cntcycle := cycle_count'First;
            TIO.Flush (logs (success));
            TIO.Flush (logs (failure));
            TIO.Flush (logs (skipped));
            TIO.Flush (logs (total));
            if curses_support then
               if cntrefresh = refresh_count'Last then
                  cntrefresh := refresh_count'First;
                  DPY.set_full_redraw_next_update;
               else
                  cntrefresh := cntrefresh + 1;
               end if;
               sumdata.Initially := bld_counter (total);
               sumdata.Built     := bld_counter (success);
               sumdata.Failed    := bld_counter (failure);
               sumdata.Ignored   := bld_counter (ignored);
               sumdata.Skipped   := bld_counter (skipped);
               sumdata.elapsed   := CYC.elapsed_now;
               sumdata.swap      := get_swap_status;
               sumdata.load      := REP.Platform.get_instant_load;
               sumdata.pkg_hour  := hourly_build_rate;
               sumdata.impulse   := impulse_rate;
               DPY.summarize (sumdata);

               for b in builders'First .. num_builders loop
                  case software_framework is
                  when ports_collection =>
                     if builder_states (b) = shutdown then
                        DPY.update_builder (FPC.builder_status (b, True, False));
                     elsif builder_states (b) = idle then
                        DPY.update_builder (FPC.builder_status (b, False, True));
                     else
                        CYC.set_log_lines (b);
                        DPY.update_builder (FPC.builder_status (b));
                     end if;
                  when pkgsrc =>
                     if builder_states (b) = shutdown then
                        DPY.update_builder (NPS.builder_status (b, True, False));
                     elsif builder_states (b) = idle then
                        DPY.update_builder (NPS.builder_status (b, False, True));
                     else
                        CYC.set_log_lines (b);
                        DPY.update_builder (NPS.builder_status (b));
                     end if;
                  end case;
               end loop;
               DPY.refresh_builder_window;
               DPY.refresh_history_window;
            else
               --  text mode support, periodic status reports
               if cntalert = alert_count'Last then
                  cntalert := alert_count'First;
                  declare
                     Remaining : constant Integer := bld_counter (total) -
                       bld_counter (success) - bld_counter (failure) -
                       bld_counter (ignored) - bld_counter (skipped);
                  begin
                     TIO.Put_Line (CYC.elapsed_now & " =>    " &
                                     "  Left:" & Remaining'Img &
                                     "  Succ:" & bld_counter (success)'Img &
                                     "  Fail:" & bld_counter (failure)'Img &
                                     "  Skip:" & bld_counter (skipped)'Img &
                                     "   Ign:" & bld_counter (ignored)'Img);
                  end;
               else
                  cntalert := cntalert + 1;
               end if;

               --  Update log lines every 4 seconds for the watchdog
               if cntrefresh = refresh_count'Last then
                  cntrefresh := refresh_count'First;
                  for b in builders'First .. num_builders loop
                     if builder_states (b) /= shutdown and then
                       builder_states (b) /= idle
                     then
                        CYC.set_log_lines (b);
                     end if;
                  end loop;
               else
                  cntrefresh := cntrefresh + 1;
               end if;
            end if;

            --  Generate latest history file every 3 seconds.
            --  With a poll period of 6 seconds, we need twice that frequency to avoid aliasing
            --  Note that in text mode, the logs are updated every 4 seconds, so in this mode
            --  the log lines will often be identical for a cycle.
            if cntwww = www_count'Last then
               cntwww := www_count'First;
               write_history_json;
               write_summary_json (active            => True,
                                   states            => builder_states,
                                   num_builders      => num_builders,
                                   num_history_files => history.segment);
            else
               cntwww := cntwww + 1;
            end if;
         else
            cntcycle := cntcycle + 1;
         end if;
         delay 0.10;
      end loop;
      if PM.configuration.avec_ncurses and then curses_support
      then
         DPY.terminate_monitor;
      end if;
      write_history_json;
      write_summary_json (active            => False,
                          states            => builder_states,
                          num_builders      => num_builders,
                          num_history_files => history.segment);
      run_hook (run_end, "PORTS_BUILT=" & JT.int2str (bld_counter (success)) &
                  " PORTS_FAILED=" & JT.int2str (bld_counter (failure)) &
                  " PORTS_IGNORED=" & JT.int2str (bld_counter (ignored)) &
                  " PORTS_SKIPPED=" & JT.int2str (bld_counter (skipped)));
   end parallel_bulk_run;


   --------------------
   --  lock_package  --
   --------------------
   procedure lock_package (id : port_id) is
   begin
      if id /= port_match_failed then
         all_ports (id).work_locked := True;
      end if;
   end lock_package;


   ----------------------------
   --  cascade_failed_build  --
   ----------------------------
   procedure cascade_failed_build (id : port_id; numskipped : out Natural;
                                   logs : dim_handlers)
   is
      purged  : PortScan.port_id;
      culprit : constant String := port_name (id);
   begin
      numskipped := 0;
      loop
         purged := skip_next_reverse_dependency (id);
         exit when purged = port_match_failed;
         if skip_verified (purged) then
            numskipped := numskipped + 1;
            TIO.Put_Line (logs (total), "           Skipped: " &
                            port_name (purged));
            TIO.Put_Line (logs (skipped),
                          port_name (purged) & " by " & culprit);
            DPY.insert_history (assemble_HR (1, purged, DPY.action_skipped));
            record_history_skipped (elapsed => CYC.elapsed_now,
                                    origin  => port_name (purged),
                                    reason  => culprit);
            run_package_hook (pkg_skipped, purged);
         end if;
      end loop;
      unlist_port (id);
   end cascade_failed_build;


   --------------------------------
   --  cascade_successful_build  --
   --------------------------------
   procedure cascade_successful_build (id : port_id)
   is
      procedure cycle (cursor : block_crate.Cursor);
      procedure cycle (cursor : block_crate.Cursor)
      is
         target : constant port_index := block_crate.Element (cursor);
      begin
         if all_ports (target).blocked_by.Contains (Key => id) then
            all_ports (target).blocked_by.Delete (Key => id);
         else
            raise seek_failure
              with port_name (target) & " was expected to be blocked by " &
              port_name (id);
         end if;
      end cycle;
   begin
      all_ports (id).blocks.Iterate (cycle'Access);
      delete_rank (id);
   end cascade_successful_build;


   --------------------------
   --  top_buildable_port  --
   --------------------------
   function top_buildable_port return port_id
   is
      list_len : constant Integer := Integer (rank_queue.Length);
      cursor   : ranking_crate.Cursor;
      QR       : queue_record;
      result   : port_id := port_match_failed;
   begin
      if list_len = 0 then
         return result;
      end if;
      cursor := rank_queue.First;
      for k in 1 .. list_len loop
         QR := ranking_crate.Element (Position => cursor);
         if not all_ports (QR.ap_index).work_locked and then
           all_ports (QR.ap_index).blocked_by.Is_Empty
         then
            result := QR.ap_index;
            exit;
         end if;
         cursor := ranking_crate.Next (Position => cursor);
      end loop;
      if SIG.graceful_shutdown_requested then
         return port_match_failed;
      end if;
      return result;
   end top_buildable_port;


   ----------------------------
   --  shutdown_recommended  --
   ----------------------------
   function shutdown_recommended (active_builders : Positive) return Boolean
   is
      list_len : constant Natural  := Integer (rank_queue.Length);
      list_max : constant Positive := 2 * active_builders;
      num_wait : Natural := 0;
      cursor   : ranking_crate.Cursor;
      QR       : queue_record;
   begin
      if list_len = 0 or else list_len >= list_max then
         return False;
      end if;
      cursor := rank_queue.First;
      for k in 1 .. list_len loop
         QR := ranking_crate.Element (Position => cursor);
         if not all_ports (QR.ap_index).work_locked then
            num_wait := num_wait + 1;
            if num_wait >= active_builders then
               return False;
            end if;
         end if;
         cursor := ranking_crate.Next (Position => cursor);
      end loop;
      return True;
   end shutdown_recommended;


   --------------------
   --  nothing_left  --
   --------------------
   function nothing_left (num_builders : builders) return Boolean
   is
      list_len : constant Integer := Integer (rank_queue.Length);
   begin
      return list_len = 0;
   end nothing_left;


   ------------------
   --  rank_arrow  --
   ------------------
   function rank_arrow (id : port_id) return ranking_crate.Cursor
   is
      rscore : constant port_index := all_ports (id).reverse_score;
      seek_target : constant queue_record := (ap_index      => id,
                                              reverse_score => rscore);
   begin
      return rank_queue.Find (seek_target);
   end rank_arrow;


   -------------------
   --  delete_rank  --
   -------------------
   procedure delete_rank (id : port_id)
   is
      rank_cursor : ranking_crate.Cursor := rank_arrow (id);
      use type ranking_crate.Cursor;
   begin
      if rank_cursor /= ranking_crate.No_Element then
         rank_queue.Delete (Position => rank_cursor);
      end if;
   end delete_rank;


   --------------------
   --  still_ranked  --
   --------------------
   function still_ranked (id : port_id) return Boolean
   is
      rank_cursor : ranking_crate.Cursor := rank_arrow (id);
      use type ranking_crate.Cursor;
   begin
      return rank_cursor /= ranking_crate.No_Element;
   end still_ranked;


   ------------------------
   --  integrity_intact  --
   ------------------------
   function integrity_intact return Boolean
   is
      procedure check_dep (cursor : block_crate.Cursor);
      procedure check_rank (cursor : ranking_crate.Cursor);

      intact : Boolean := True;
      procedure check_dep (cursor : block_crate.Cursor)
      is
         did : constant port_index := block_crate.Element (cursor);
      begin
         if not still_ranked (did) then
            intact := False;
         end if;
      end check_dep;

      procedure check_rank (cursor : ranking_crate.Cursor)
      is
         QR : constant queue_record := ranking_crate.Element (cursor);
      begin
         if intact then
            all_ports (QR.ap_index).blocked_by.Iterate (check_dep'Access);
         end if;
      end check_rank;
   begin
      rank_queue.Iterate (check_rank'Access);
      return intact;
   end integrity_intact;


   ---------------------
   --  skip_verified  --
   ---------------------
   function skip_verified (id : port_id) return Boolean is
   begin
      if id = port_match_failed then
         return False;
      end if;
      return not all_ports (id).unlist_failed;
   end skip_verified;


   --------------------
   --  queue_length  --
   --------------------
   function queue_length return Integer is
   begin
      return Integer (rank_queue.Length);
   end queue_length;


   -------------------
   --  unlist_port  --
   -------------------
   procedure unlist_port (id : port_id) is
   begin
      if id = port_match_failed then
         return;
      end if;
      if still_ranked (id) then
         delete_rank (id);
      else
         --  don't raise exception.  Since we don't prune all_reverse as
         --  we go, there's no guarantee the reverse dependency hasn't already
         --  been removed (e.g. when it is a common reverse dep)
         all_ports (id).unlist_failed := True;
      end if;
   end unlist_port;


   ------------------------------------
   --  skip_next_reverse_dependency  --
   ------------------------------------
   function skip_next_reverse_dependency (pinnacle : port_id) return port_id
   is
      rev_cursor : block_crate.Cursor;
      next_dep : port_index;
   begin
      if all_ports (pinnacle).all_reverse.Is_Empty then
         return port_match_failed;
      end if;
      rev_cursor := all_ports (pinnacle).all_reverse.First;
      next_dep := block_crate.Element (rev_cursor);
      unlist_port (id => next_dep);
      all_ports (pinnacle).all_reverse.Delete (rev_cursor);

      return next_dep;
   end skip_next_reverse_dependency;


   ---------------------
   --  ignore_reason  --
   ---------------------
   function ignore_reason (id : port_id) return String is
   begin
      if id = port_match_failed or else
        id > last_port
      then
         return "Invalid port ID";
      end if;
      return JT.USS (all_ports (id).ignore_reason);
   end ignore_reason;


   -------------------------
   --  next_ignored_port  --
   -------------------------
   function next_ignored_port return port_id
   is
      list_len : constant Integer := Integer (rank_queue.Length);
      cursor   : ranking_crate.Cursor;
      QR       : queue_record;
      result   : port_id := port_match_failed;
   begin
      if list_len = 0 then
         return result;
      end if;
      cursor := rank_queue.First;
      for k in 1 .. list_len loop
         QR := ranking_crate.Element (Position => cursor);
         if all_ports (QR.ap_index).ignored then
            result := QR.ap_index;
            DPY.insert_history (assemble_HR (1, QR.ap_index,
                                DPY.action_ignored));
            run_package_hook (pkg_ignored, QR.ap_index);
            exit;
         end if;
         cursor := ranking_crate.Next (Position => cursor);
      end loop;
      return result;
   end next_ignored_port;


   -----------------
   --  port_name  --
   -----------------
   function port_name (id : port_id) return String is
   begin
      if id = port_match_failed or else
        id > last_port
      then
         return "Invalid port ID";
      end if;
      return get_catport (all_ports (id));
   end port_name;


   -----------------------
   --  get_swap_status  --
   -----------------------
   function get_swap_status return Float
   is
      type memtype is mod 2**64;
      command : String := REP.Platform.swapinfo_command;
      status  : Integer;
      comres  : JT.Text;

      blocks_total : memtype := 0;
      blocks_used  : memtype := 0;
   begin
      comres := Unix.piped_command (command, status);
      if status /= 0 then
         return 200.0;  --  [ERROR] Signal to set swap display to "N/A"
      end if;
      --  Throw first line away, e.g "Device 1K-blocks Used  Avail ..."
      --  Distinguishes platforms though:
      --     Net/Free/Dragon start with "Device"
      --     Linux starts with "NAME"
      --     Solaris starts with "swapfile"
      --  On FreeBSD (DragonFly too?), when multiple swap used, ignore line starting "Total"
      declare
         command_result : String := JT.USS (comres);
         markers        : JT.Line_Markers;
         line_present   : Boolean;
      begin
         JT.initialize_markers (command_result, markers);
         --  Throw first line away (valid for all platforms
         line_present := JT.next_line_present (command_result, markers);
         if line_present then
            declare
               line : String := JT.extract_line (command_result, markers);
            begin
               null;
            end;
         else
            return 200.0;  --  [ERROR] Signal to set swap display to "N/A"
         end if;
         loop
            exit when not JT.next_line_present (command_result, markers);
            declare
               line : constant String :=
                 JT.strip_excessive_spaces (JT.extract_line (command_result, markers));
            begin
               if JT.specific_field (line, 1) /= "Total" then
                  blocks_total := blocks_total + memtype'Value (JT.specific_field (line, 2));
                  blocks_used  := blocks_used  + memtype'Value (JT.specific_field (line, 3));
               end if;
            exception
               when Constraint_Error =>
                  return  200.0;  --  [ERROR] Signal to set swap display to "N/A"
            end;
         end loop;
      end;
      if blocks_total = 0 then
         return 200.0;  --  Signal to set swap display to "N/A"
      else
         return 100.0 * Float (blocks_used) / Float (blocks_total);
      end if;
   end get_swap_status;


   -------------------------
   --  hourly_build_rate  --
   -------------------------
   function hourly_build_rate return Natural
   is
      pkg_that_count : constant Natural := bld_counter (success) +
                                           bld_counter (failure);
   begin
      return CYC.get_packages_per_hour (pkg_that_count, start_time);
   end hourly_build_rate;


   --------------------
   --  impulse_rate  --
   --------------------
   function impulse_rate return Natural
   is
      pkg_that_count : constant Natural := bld_counter (success) +
                                           bld_counter (failure);
      pkg_diff : Natural;
      result   : Natural;
   begin
      if impulse_counter = impulse_range'Last then
         impulse_counter := impulse_range'First;
      else
         impulse_counter := impulse_counter + 1;
      end if;
      if impulse_data (impulse_counter).virgin then
         impulse_data (impulse_counter).hack     := CAL.Clock;
         impulse_data (impulse_counter).packages := pkg_that_count;
         impulse_data (impulse_counter).virgin   := False;

         return CYC.get_packages_per_hour (pkg_that_count, start_time);
      end if;
      pkg_diff := pkg_that_count - impulse_data (impulse_counter).packages;
      result   := CYC.get_packages_per_hour
                   (packages_done => pkg_diff,
                    from_when     => impulse_data (impulse_counter).hack);
      impulse_data (impulse_counter).hack     := CAL.Clock;
      impulse_data (impulse_counter).packages := pkg_that_count;

      return result;
   exception
      when others => return 0;
   end impulse_rate;


   -------------------
   --  assemble_HR  --
   -------------------
   function assemble_HR (slave : builders; pid : port_id;
                         action : DPY.history_action)
                         return DPY.history_rec
   is
      HR : DPY.history_rec;
      HOLast   : constant Natural := DPY.history_origin'Last;
      catport  : String := port_name (pid);
      hyphens  : constant DPY.history_elapsed := "--:--:--";
   begin
      HR.id := slave;
      HR.slavid      := JT.zeropad (Integer (slave), 2);
      HR.established := True;
      HR.action      := action;
      HR.origin      := (others => ' ');
      HR.run_elapsed := CYC.elapsed_now;
      if action = DPY.action_shutdown then
         HR.pkg_elapsed := hyphens;
      else
         if action = DPY.action_skipped or else
           action = DPY.action_ignored
         then
            HR.pkg_elapsed := hyphens;
         else
            HR.pkg_elapsed := CYC.elapsed_build (slave);
         end if;
         if catport'Last > HOLast then
            HR.origin (1 .. HOLast - 1) := catport (1 .. HOLast - 1);
            HR.origin (HOLast) := LAT.Asterisk;
         else
            HR.origin (1 .. catport'Last) := catport;
         end if;
      end if;
      return HR;
   end assemble_HR;


   ------------------------
   --  initialize_hooks  --
   ------------------------
   procedure initialize_hooks is
   begin
      for hook in hook_type'Range loop
         declare
            script : constant String := JT.USS (hook_location (hook));
         begin
            active_hook (hook) := AD.Exists (script) and then
              REP.Platform.file_is_executable (script);
         end;
      end loop;
   end initialize_hooks;


   ----------------------
   --  run_start_hook  --
   ----------------------
   procedure run_start_hook is
   begin
      run_hook (run_start, "PORTS_QUEUED=" & JT.int2str (queue_length) & " ");
   end run_start_hook;


   ----------------
   --  run_hook  --
   ----------------
   procedure run_hook (hook : hook_type; envvar_list : String)
   is
      function nvpair (name : String; value : JT.Text) return String;
      function nvpair (name : String; value : JT.Text) return String is
      begin
         return name & LAT.Equals_Sign & LAT.Quotation &
           JT.USS (value) & LAT.Quotation & LAT.Space;
      end nvpair;
      common_env : constant String :=
        nvpair ("PROFILE", PM.configuration.profile) &
        nvpair ("DIR_PACKAGES", PM.configuration.dir_packages) &
        nvpair ("DIR_REPOSITORY", PM.configuration.dir_repository) &
        nvpair ("DIR_PORTS", PM.configuration.dir_portsdir) &
        nvpair ("DIR_OPTIONS", PM.configuration.dir_options) &
        nvpair ("DIR_DISTFILES", PM.configuration.dir_distfiles) &
        nvpair ("DIR_LOGS", PM.configuration.dir_logs) &
        nvpair ("DIR_BUILDBASE", PM.configuration.dir_buildbase);
      --  The follow command works on every platform
      command : constant String := "/usr/bin/env -i " & common_env &
        envvar_list & " " & JT.USS (hook_location (hook));
   begin
      if not active_hook (hook) then
         return;
      end if;
      if Unix.external_command (command) then
         null;
      end if;
   end run_hook;


   ------------------------
   --  run_package_hook  --
   ------------------------
   procedure run_package_hook (hook : hook_type; id : port_id)
   is
      pn   : constant String := port_name (id);
      tail : String := " ORIGIN=" & JT.part_1 (pn, "@") &
        " FLAVOR=" & JT.part_2 (pn, "@") &
        " PKGNAME=" & package_name (id) & " ";
   begin
      case hook is
         when pkg_success => run_hook (hook, "RESULT=success" & tail);
         when pkg_failure => run_hook (hook, "RESULT=failure" & tail);
         when pkg_ignored => run_hook (hook, "RESULT=ignored" & tail);
         when pkg_skipped => run_hook (hook, "RESULT=skipped" & tail);
         when others => null;
      end case;
   end run_package_hook;


   ----------------------------
   --  run_hook_after_build  --
   ----------------------------
   procedure run_hook_after_build (built : Boolean; id : port_id) is
   begin
      if built then
         run_package_hook (pkg_success, id);
      else
         run_package_hook (pkg_failure, id);
      end if;
   end run_hook_after_build;


   --------------------
   --  package_name  --
   --------------------
   function package_name (id : port_id) return String is
   begin
      if id = port_match_failed or else
        id > last_port
      then
         return "Invalid port ID";
      end if;
      declare
         fullname : constant String := JT.USS (all_ports (id).package_name);
      begin
         return fullname (1 .. fullname'Length - 4);
      end;
   end package_name;


   -----------------------------
   --  initialize_web_report  --
   -----------------------------
   procedure initialize_web_report (num_builders : builders) is
      idle_slaves  : constant dim_builder_state := (others => idle);
      reportdir    : constant String := JT.USS (PM.configuration.dir_logs) & "/Report";
      sharedir     : constant String := host_localbase & "/share/synth";
   begin
      AD.Create_Path (reportdir);
      AD.Copy_File (sharedir & "/synth.png",     reportdir & "/synth.png");
      AD.Copy_File (sharedir & "/favicon.png",   reportdir & "/favicon.png");
      AD.Copy_File (sharedir & "/progress.js",   reportdir & "/progress.js");
      AD.Copy_File (sharedir & "/progress.css",  reportdir & "/progress.css");
      AD.Copy_File (sharedir & "/progress.html", reportdir & "/index.html");
      write_summary_json (active            => True,
                          states            => idle_slaves,
                          num_builders      => num_builders,
                          num_history_files => 0);
   end initialize_web_report;


   -----------------------------------------
   --  delete_existing_web_history_files  --
   -----------------------------------------
   procedure delete_existing_web_history_files
   is
      search    : AD.Search_Type;
      dirent    : AD.Directory_Entry_Type;
      pattern   : constant String := "*_history.json";
      filter    : constant AD.Filter_Type := (AD.Ordinary_File => True, others => False);
      reportdir : constant String := JT.USS (PM.configuration.dir_logs) & "/Report";
   begin
      if not AD.Exists (reportdir) then
         return;
      end if;
      AD.Start_Search (Search    => search,
                       Directory => reportdir,
                       Pattern   => pattern,
                       Filter    => filter);
      while AD.More_Entries (search) loop
         AD.Get_Next_Entry (search, dirent);
         AD.Delete_File (reportdir & "/" & AD.Simple_Name (dirent));
      end loop;
   exception
      when AD.Name_Error => null;
   end delete_existing_web_history_files;


   -----------------------
   --  nv (2 versions)  --
   -----------------------
   function nv (name, value : String) return String is
   begin
      return ASCII.Quotation & name & ASCII.Quotation & ASCII.Colon &
        ASCII.Quotation & value & ASCII.Quotation;
   end nv;

   function nv (name : String; value : Integer) return String is
   begin
      return ASCII.Quotation & name & ASCII.Quotation & ASCII.Colon & JT.int2str (value);
   end nv;


   --------------------------
   --  write_summary_json  --
   --------------------------
   procedure write_summary_json
     (active            : Boolean;
      states            : dim_builder_state;
      num_builders      : builders;
      num_history_files : Natural)
   is
      function TF (value : Boolean) return Natural;

      function TF (value : Boolean) return Natural is
      begin
         if value then
            return 1;
         else
            return 0;
         end if;
      end TF;

      jsonfile : TIO.File_Type;
      filename : constant String := JT.USS (PM.configuration.dir_logs) & "/Report/summary.json";
      leftover : constant Integer := bld_counter (total) - bld_counter (success) -
                 bld_counter (failure) - bld_counter (ignored) - bld_counter (skipped);
      slave    : DPY.builder_rec;
   begin
      --  Try to defend malicious symlink: https://en.wikipedia.org/wiki/Symlink_race
      if AD.Exists (filename) then
         AD.Delete_File (filename);
      end if;
      TIO.Create (File => jsonfile,
                  Mode => TIO.Out_File,
                  Name => filename);
      TIO.Put (jsonfile, "{" & ASCII.LF &
           "  " & nv ("profile", JT.USS (PM.configuration.profile)) & ASCII.LF);
      TIO.Put
        (jsonfile,
           " ," & nv ("kickoff", timestamp (start_time, True)) & ASCII.LF &
           " ," & nv ("kfiles", num_history_files) & ASCII.LF &
           " ," & nv ("active", TF (active)) & ASCII.LF &
           " ," & ASCII.Quotation & "stats" & ASCII.Quotation & ASCII.Colon & "{" & ASCII.LF);
      TIO.Put
        (jsonfile,
           "   " & nv ("queued",   bld_counter (total))   & ASCII.LF &
           "  ," & nv ("built",    bld_counter (success)) & ASCII.LF &
           "  ," & nv ("failed",   bld_counter (failure)) & ASCII.LF &
           "  ," & nv ("ignored",  bld_counter (ignored)) & ASCII.LF &
           "  ," & nv ("skipped",  bld_counter (skipped)) & ASCII.LF &
           "  ," & nv ("remains",  leftover)              & ASCII.LF &
           "  ," & nv ("elapsed",  CYC.elapsed_now)       & ASCII.LF &
           "  ," & nv ("pkghour",  hourly_build_rate)     & ASCII.LF &
           "  ," & nv ("impulse",  impulse_rate)          & ASCII.LF &
           "  ," & nv ("swapinfo", DPY.fmtpc (get_swap_status, True)) & ASCII.LF &
           "  ," & nv ("load",     DPY.fmtload (REP.Platform.get_instant_load)) & ASCII.LF &
           " }" & ASCII.LF &
           " ," & ASCII.Quotation & "builders" & ASCII.Quotation & ASCII.Colon & "[" & ASCII.LF);

      for b in builders'First .. num_builders loop
         case software_framework is
            when ports_collection =>
               if states (b) = shutdown then
                  slave := FPC.builder_status (b, True, False);
               elsif states (b) = idle then
                  slave := FPC.builder_status (b, False, True);
               else
                  slave := FPC.builder_status (b);
               end if;
            when pkgsrc =>
               if states (b) = shutdown then
                  slave := NPS.builder_status (b, True, False);
               elsif states (b) = idle then
                  slave := NPS.builder_status (b, False, True);
               else
                  slave := NPS.builder_status (b);
               end if;
         end case;
         if b = builders'First then
            TIO.Put (jsonfile, "  {" & ASCII.LF);
         else
            TIO.Put (jsonfile, "  ,{" & ASCII.LF);
         end if;

         TIO.Put
           (jsonfile,
              "    " & nv ("ID",      slave.slavid)  & ASCII.LF &
              "   ," & nv ("elapsed", JT.trim (slave.Elapsed)) & ASCII.LF &
              "   ," & nv ("phase",   JT.trim (slave.phase))   & ASCII.LF &
              "   ," & nv ("origin",  JT.trim (slave.origin))  & ASCII.LF &
              "   ," & nv ("lines",   JT.trim (slave.LLines))  & ASCII.LF &
              "  }" & ASCII.LF);
      end loop;
      TIO.Put (jsonfile, " ]" & ASCII.LF & "}" & ASCII.LF);
      TIO.Close (jsonfile);
   exception
      when others =>
         if TIO.Is_Open (jsonfile) then
            TIO.Close (jsonfile);
         end if;
   end write_summary_json;


   ----------------------------
   --  write_history_json  --
   ----------------------------
   procedure write_history_json
   is
      jsonfile : TIO.File_Type;
      filename : constant String := JT.USS (PM.configuration.dir_logs) &
                 "/Report/" & JT.zeropad (history.segment, 2) & "_history.json";
   begin
      if history.segment_count = 0 then
         return;
      end if;
      if history.last_written = history.last_index then
         return;
      end if;
      TIO.Create (File => jsonfile,
                  Mode => TIO.Out_File,
                  Name => filename);
      TIO.Put (jsonfile, history.content (1 .. history.last_index));
      TIO.Put (jsonfile, "]");
      TIO.Close (jsonfile);
      history.last_written := history.last_index;
   exception
      when others =>
         if TIO.Is_Open (jsonfile) then
            TIO.Close (jsonfile);
         end if;
   end write_history_json;


   ----------------------------
   --  assimulate_substring  --
   ----------------------------
   procedure assimulate_substring
     (history : in out progress_history;
      substring : String)
   is
      first : constant Positive := history.last_index + 1;
      last  : constant Positive := history.last_index + substring'Length;
   begin
      --  silently fail (this shouldn't be practically possible)
      if last < kfile_content'Last then
         history.content (first .. last) := substring;
      end if;
      history.last_index := last;
   end assimulate_substring;


   ----------------------------
   --  record_history_built  --
   ----------------------------
   procedure handle_first_history_entry is
   begin
      if history.segment_count = 1 then
         assimulate_substring (history, "[" & ASCII.LF & " {" & ASCII.LF);
      else
         assimulate_substring (history, " ,{" & ASCII.LF);
      end if;
   end handle_first_history_entry;


   ----------------------------
   --  record_history_built  --
   ----------------------------
   procedure record_history_built
     (elapsed   : String;
      slave_id  : builders;
      origin    : String;
      duration  : String)
   is
      ID : constant String := JT.zeropad (Integer (slave_id), 2);
   begin
      history.log_entry := history.log_entry + 1;
      history.segment_count := history.segment_count + 1;
      handle_first_history_entry;

      assimulate_substring (history, "   " & nv ("entry", history.log_entry) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("elapsed", elapsed) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("ID", ID) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("result", "built") & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("origin", origin) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("info", "") & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("duration", duration) & ASCII.LF);
      assimulate_substring (history, " }" & ASCII.LF);

      check_history_segment_capacity;
   end record_history_built;


   -----------------------------
   --  record_history_failed  --
   -----------------------------
   procedure record_history_failed
     (elapsed   : String;
      slave_id  : builders;
      origin    : String;
      duration  : String;
      die_phase : String;
      skips     : Natural)
   is
      info : constant String := die_phase & ":" & JT.int2str (skips);
      ID   : constant String := JT.zeropad (Integer (slave_id), 2);
   begin
      history.log_entry := history.log_entry + 1;
      history.segment_count := history.segment_count + 1;
      handle_first_history_entry;

      assimulate_substring (history, "   " & nv ("entry", history.log_entry) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("elapsed", elapsed) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("ID", ID)  & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("result", "failed") & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("origin", origin) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("info", info) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("duration", duration) & ASCII.LF);
      assimulate_substring (history, " }" & ASCII.LF);

      check_history_segment_capacity;
   end record_history_failed;


   ------------------------------
   --  record_history_ignored  --
   ------------------------------
   procedure record_history_ignored
     (elapsed   : String;
      origin    : String;
      reason    : String;
      skips     : Natural)
   is
      cleantxt : constant String := JT.strip_control (reason);
      info : constant String :=
        JT.replace_char
          (JT.replace_char (cleantxt, ASCII.Quotation, "&nbsp;"), ASCII.Back_Slash, "&#92;")
          & ":|:" & JT.int2str (skips);
   begin
      history.log_entry := history.log_entry + 1;
      history.segment_count := history.segment_count + 1;
      handle_first_history_entry;

      assimulate_substring (history, "   " & nv ("entry", history.log_entry) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("elapsed", elapsed) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("ID", "--") & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("result", "ignored") & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("origin", origin) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("info", info) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("duration", "--:--:--") & ASCII.LF);
      assimulate_substring (history, " }" & ASCII.LF);

      check_history_segment_capacity;
   end record_history_ignored;


   ------------------------------
   --  record_history_skipped  --
   ------------------------------
   procedure record_history_skipped
     (elapsed   : String;
      origin    : String;
      reason    : String)
   is
   begin
      history.log_entry := history.log_entry + 1;
      history.segment_count := history.segment_count + 1;
      handle_first_history_entry;

      assimulate_substring (history, "   " & nv ("entry", history.log_entry) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("elapsed", elapsed) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("ID", "--") & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("result", "skipped") & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("origin", origin) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("info", reason) & ASCII.LF);
      assimulate_substring (history, "  ," & nv ("duration", "--:--:--") & ASCII.LF);
      assimulate_substring (history, " }" & ASCII.LF);

      check_history_segment_capacity;
   end record_history_skipped;


   --------------------------------------
   --  check_history_segment_capacity  --
   --------------------------------------
   procedure check_history_segment_capacity is
   begin
      if history.segment_count = 1 then
         history.segment := history.segment + 1;
         return;
      end if;
      if history.segment_count < kfile_units_limit then
         return;
      end if;
      write_history_json;

      history.last_index    := 0;
      history.last_written  := 0;
      history.segment_count := 0;

   end check_history_segment_capacity;

end PortScan.Ops;
