package com.store.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.store.model.UpdateStatus;

@Repository
public interface UpdateStatusRepository extends JpaRepository<UpdateStatus, Integer> {
	
	@Query("""
			select s from UpdateStatus s where s.orders.orderID = ?1 order by s.id desc
			""")
	<T> List<T> findBy(Integer id,Class<T> classType);
}
