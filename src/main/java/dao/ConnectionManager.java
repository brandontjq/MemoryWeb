/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.*;
import java.util.Properties;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * A class that manages connections to the database. It also has a utility
 * method that close connections, statements and resultsets
 */
public class ConnectionManager {

  //private static final String PROPS_FILENAME = "/memoryweb/connection.properties";
  private static String dbUser = "root";
  private static String dbPassword = "";
  private static String dbURL = "jdbc:mysql://" + "localhost" + ":" + "3306" + "/" + "memoryweb"  + "?useUnicode=yes&characterEncoding=UTF-8";;

  static {
    initDBDriver();
  }
  
  private static void initDBDriver() {
    try {
      Class.forName("com.mysql.jdbc.Driver").newInstance();
    } catch (Exception ex) {
      // unable to load properties file
      String message = "Unable to find JDBC driver for MySQL.";
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
      throw new RuntimeException(message, ex);
    }
  }

  /**
   * Gets a connection to the database
   *
   * @return the connection
   * @throws SQLException if an error occurs when connecting
   */
  public static Connection getConnection() throws SQLException {
    String message = "dbURL: " + dbURL
            + "  , dbUser: " + dbUser
            + "  , dbPassword: " + dbPassword;
    Logger.getLogger(ConnectionManager.class.getName()).log(Level.INFO, message);

    return DriverManager.getConnection(dbURL, dbUser, dbPassword);

  }

  /**
   * close the given connection, statement and resultset
   *
   * @param conn the connection object to be closed
   * @param stmt the statement object to be closed
   * @param rs the resultset object to be closed
   */
  public static void close(Connection conn, Statement stmt, ResultSet rs) {
    try {
      if (rs != null) {
        rs.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close ResultSet", ex);
    }
    try {
      if (stmt != null) {
        stmt.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close Statement", ex);
    }
    try {
      if (conn != null) {
        conn.close();
      }
    } catch (SQLException ex) {
      Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
              "Unable to close Connection", ex);
    }
  }

  /**
   * Closes the connection without ResultSet
   * @param conn A Connection object
   * @see Connection
   * @param stmt A Statement object
   * @see Statement
   */  
  public static void close(Connection conn, Statement stmt) {
    close(conn, stmt, null);
  }

  /**
   * Closes the connection without ResultSet and Statement
   * @param conn A Connection object
   * @see Connection
   */  
  public static void close(Connection conn) {
    close(conn, null, null);
  }

  /**
   * Closes the connection without ResultSet and Connection
   * @param stmt A Statement object
   * @see Statement
   */  
  public static void close(Statement stmt) {
    close(null, stmt, null);
  }

  /**
   * Closes the connection without Connection
   * @param stmt A Statement object
   * @see Statement
   * @param rs A ResultSet object
   * @see ResultSet
   */  
  public static void close(Statement stmt, ResultSet rs) {
    close(null, stmt, rs);
  }
  
}