// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FilmDao? _filmDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Film` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `shortDesc` TEXT NOT NULL, `imageURL` TEXT NOT NULL, `overview` TEXT NOT NULL, `genre` TEXT NOT NULL, `voteAverage` TEXT NOT NULL, `year` TEXT NOT NULL, `releaseDateMonth` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FilmDao get filmDao {
    return _filmDaoInstance ??= _$FilmDao(database, changeListener);
  }
}

class _$FilmDao extends FilmDao {
  _$FilmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _filmInsertionAdapter = InsertionAdapter(
            database,
            'Film',
            (Film item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'shortDesc': item.shortDesc,
                  'imageURL': item.imageURL,
                  'overview': item.overview,
                  'genre': item.genre,
                  'voteAverage': item.voteAverage,
                  'year': item.year,
                  'releaseDateMonth': item.releaseDateMonth,
                  'releaseDate': item.releaseDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Film> _filmInsertionAdapter;

  @override
  Future<List<Film>> findAllFilms() async {
    return _queryAdapter.queryList('SELECT * FROM Film',
        mapper: (Map<String, Object?> row) => Film(
            row['id'] as int,
            row['title'] as String,
            row['shortDesc'] as String,
            row['imageURL'] as String,
            row['overview'] as String,
            row['genre'] as String,
            row['voteAverage'] as String,
            row['year'] as String,
            row['releaseDateMonth'] as String,
            row['releaseDate'] as String));
  }

  @override
  Stream<Film?> findFilmById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Film WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Film(
            row['id'] as int,
            row['title'] as String,
            row['shortDesc'] as String,
            row['imageURL'] as String,
            row['overview'] as String,
            row['genre'] as String,
            row['voteAverage'] as String,
            row['year'] as String,
            row['releaseDateMonth'] as String,
            row['releaseDate'] as String),
        arguments: [id],
        queryableName: 'Film',
        isView: false);
  }

  @override
  Future<void> insertFilm(Film film) async {
    await _filmInsertionAdapter.insert(film, OnConflictStrategy.abort);
  }
}
