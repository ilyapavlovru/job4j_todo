package ru.job4j.todo.store;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.todo.model.Item;

import java.util.Collection;
import java.util.function.Function;

public class HbmTodoStore implements Store, AutoCloseable {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
            .configure().build();
    private final SessionFactory sf = new MetadataSources(registry)
            .buildMetadata().buildSessionFactory();

    private <T> T tx(final Function<Session, T> command) {
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            T rsl = command.apply(session);
            session.getTransaction().commit();
            return rsl;
        }
    }

    @Override
    public Collection<Item> findAllItems() {
        return tx(
                session -> session.createQuery("from ru.job4j.todo.model.Item").list()
        );
    }

    @Override
    public Item addItem(Item item) {
        return tx(
                session -> {
                    session.save(item);
                    return item;
                }
        );
    }

    @Override
    public Item findById(int id) {
        return tx(
                session -> session.get(Item.class, id)
        );
    }

    @Override
    public boolean replace(Item item) {
        return tx(
                session -> {
                    session.update(item);
                    return true;
                }
        );
    }

    @Override
    public void close() throws Exception {
        StandardServiceRegistryBuilder.destroy(registry);
    }
}
