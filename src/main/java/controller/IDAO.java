package controller;

import java.util.ArrayList;

public interface IDAO<T> {
	public boolean create(T object);
	public ArrayList<T> read();
	public T findByID(int ID);
	public boolean update(T object);
	public boolean delete(T object);
}
