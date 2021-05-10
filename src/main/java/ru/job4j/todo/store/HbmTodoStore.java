package ru.job4j.todo.store;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.todo.model.Item;

import java.util.Collection;
import java.util.List;

public class HbmTodoStore implements Store, AutoCloseable {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
            .configure().build();
    private final SessionFactory sf = new MetadataSources(registry)
            .buildMetadata().buildSessionFactory();

    @Override
    public Collection<Item> findAllItems() {
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            List<Item> result = session.createQuery("from ru.job4j.todo.model.Item").list();
            session.getTransaction().commit();
            return result;
        }
    }

    @Override
    public Item addItem(Item item) {
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            session.save(item);
            session.getTransaction().commit();
            return item;
        }
    }

    @Override
    public void close() throws Exception {
        StandardServiceRegistryBuilder.destroy(registry);
    }
}
