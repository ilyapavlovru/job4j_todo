package ru.job4j.todo.store;

import ru.job4j.todo.model.Item;

import java.util.Collection;

public interface Store {
    Collection<Item> findAllItems();
    Item addItem(Item item);
}
