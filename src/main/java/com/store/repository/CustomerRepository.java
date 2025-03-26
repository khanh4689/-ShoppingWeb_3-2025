package com.store.repository;

import java.util.Optional;

import com.store.model.Customer;

public interface CustomerRepository extends CommonRepository<Customer, Integer> {
	Optional<Customer> findByEmailEquals(String email);
}
