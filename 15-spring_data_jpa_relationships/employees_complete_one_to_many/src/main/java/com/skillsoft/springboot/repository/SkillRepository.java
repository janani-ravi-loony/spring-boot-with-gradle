package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Skill;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SkillRepository extends JpaRepository<Skill, Long> {
}