-- 1. Create Branches Table
CREATE TABLE Branches (
    branch_id INTEGER PRIMARY KEY AUTOINCREMENT,
    branch_name TEXT NOT NULL,
    address TEXT,
    city TEXT,
    phone TEXT
);

-- 2. Create Genres Table
CREATE TABLE Genres (
    genre_id INTEGER PRIMARY KEY AUTOINCREMENT,
    genre_name TEXT NOT NULL,
    description TEXT
);

-- 3. Create Authors Table
CREATE TABLE Authors (
    author_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birth_year INTEGER,
    country TEXT
);

-- 4. Create Patrons Table
CREATE TABLE Patrons (
    patron_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT,
    address TEXT,
    city TEXT,
    registration_date TEXT NOT NULL,
    branch_id INTEGER,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE SET NULL
);

-- 5. Create Books Table
CREATE TABLE Books (
    book_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author_id INTEGER,
    genre_id INTEGER,
    isbn TEXT,
    publication_year INTEGER,
    copies_owned INTEGER DEFAULT 1,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE SET NULL,
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id) ON DELETE SET NULL
);

-- 6. Create Loans Table
CREATE TABLE Loans (
    loan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    patron_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    checkout_date TEXT NOT NULL,
    due_date TEXT NOT NULL,
    return_date TEXT, -- NULL if not yet returned
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (patron_id) REFERENCES Patrons(patron_id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE CASCADE
);

/*
A. ON DELETE SET NULL
What it does: When a record in the parent table is deleted, the foreign key column in the child table is automatically set to NULL.
Real-world meaning: If you delete an author (e.g., Ernest Hemingway) from the Authors table, the books he wrote remain in the Books table, but their author_id field becomes NULL ("Author Unknown").
Why use it? You do not want to delete physical library books from your inventory just because an author record was removed from the database.

B. ON DELETE CASCADE
What it does: When a record in the parent table is deleted, all matching child records in the child table are automatically deleted too (the deletion "cascades" down).
Real-world meaning: If a library branch is permanently closed and deleted from the Branches table, or a loan record is deleted, all associated loan activity attached specifically to that entry is automatically cleaned up and removed.
Why use it? It prevents orphaned records (e.g., a loan entry referring to a patron ID that no longer exists in your database).
*/