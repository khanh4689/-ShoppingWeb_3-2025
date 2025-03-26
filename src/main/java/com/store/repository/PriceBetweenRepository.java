package com.store.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.store.model.PriceBetween;

public interface PriceBetweenRepository extends JpaRepository<PriceBetween, Integer> {

	<T> List<T> findBy(Class<T> classType);
}
