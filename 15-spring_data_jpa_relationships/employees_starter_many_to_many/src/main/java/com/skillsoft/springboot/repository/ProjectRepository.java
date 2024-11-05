package com.skillsoft.springboot.repository;

import com.skillsoft.springboot.model.Project;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectRepository extends JpaRepository<Project, Long> {
}