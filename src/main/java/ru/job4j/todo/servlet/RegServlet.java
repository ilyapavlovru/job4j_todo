package ru.job4j.todo.servlet;

import ru.job4j.todo.model.Role;
import ru.job4j.todo.model.User;
import ru.job4j.todo.store.HbmTodoStore;
import ru.job4j.todo.store.Store;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class RegServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Store store = new HbmTodoStore();
        User existingUser = store.findUserByEmail(email);
        if (existingUser == null) {
            req.setCharacterEncoding("UTF-8");
            Role role = store.findRoleByName("ADMIN");
            if (role == null) {
                role = store.addRole(Role.of("ADMIN"));
            }
            store.addUser(User.of(name, email, password, role));
            HttpSession sc = req.getSession();
            User sessionUser = new User(name, email);
            sc.setAttribute("user", sessionUser);
            resp.sendRedirect(req.getContextPath());
        } else {
            resp.setContentType("text/html;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Пользователь с таким email уже существует');");
            out.println("location='reg.jsp';");
            out.println("</script>");
        }
    }
}
