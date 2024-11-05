package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.PerformanceStats;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PerformanceStatsRepository extends JpaRepository<PerformanceStats, Long> {
}