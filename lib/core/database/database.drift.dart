// dart format width=80
// ignore_for_file: type=lint
part of 'database.dart';

class $ProjectsTable extends Projects
    with TableInfo<$ProjectsTable, ProjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pt-BR'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settingsMeta = const VerificationMeta(
    'settings',
  );
  @override
  late final GeneratedColumn<String> settings = GeneratedColumn<String>(
    'settings',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    area,
    language,
    createdAt,
    updatedAt,
    settings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('settings')) {
      context.handle(
        _settingsMeta,
        settings.isAcceptableOrUnknown(data['settings']!, _settingsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      ),
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      settings: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settings'],
      ),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class ProjectRow extends DataClass implements Insertable<ProjectRow> {
  final String id;
  final String name;
  final String? description;
  final String? area;
  final String language;
  final int createdAt;
  final int updatedAt;

  /// JSON: ProjectSettings serialized.
  final String? settings;
  const ProjectRow({
    required this.id,
    required this.name,
    this.description,
    this.area,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    this.settings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    map['language'] = Variable<String>(language);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || settings != null) {
      map['settings'] = Variable<String>(settings);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      language: Value(language),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      settings: settings == null && nullToAbsent
          ? const Value.absent()
          : Value(settings),
    );
  }

  factory ProjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      area: serializer.fromJson<String?>(json['area']),
      language: serializer.fromJson<String>(json['language']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      settings: serializer.fromJson<String?>(json['settings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'area': serializer.toJson<String?>(area),
      'language': serializer.toJson<String>(language),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'settings': serializer.toJson<String?>(settings),
    };
  }

  ProjectRow copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> area = const Value.absent(),
    String? language,
    int? createdAt,
    int? updatedAt,
    Value<String?> settings = const Value.absent(),
  }) => ProjectRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    area: area.present ? area.value : this.area,
    language: language ?? this.language,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    settings: settings.present ? settings.value : this.settings,
  );
  ProjectRow copyWithCompanion(ProjectsCompanion data) {
    return ProjectRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      area: data.area.present ? data.area.value : this.area,
      language: data.language.present ? data.language.value : this.language,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      settings: data.settings.present ? data.settings.value : this.settings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('area: $area, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('settings: $settings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    area,
    language,
    createdAt,
    updatedAt,
    settings,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.area == this.area &&
          other.language == this.language &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.settings == this.settings);
}

class ProjectsCompanion extends UpdateCompanion<ProjectRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> area;
  final Value<String> language;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String?> settings;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.area = const Value.absent(),
    this.language = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.settings = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.area = const Value.absent(),
    this.language = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.settings = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProjectRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? area,
    Expression<String>? language,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? settings,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (area != null) 'area': area,
      if (language != null) 'language': language,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (settings != null) 'settings': settings,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? area,
    Value<String>? language,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String?>? settings,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      area: area ?? this.area,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      settings: settings ?? this.settings,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (settings.present) {
      map['settings'] = Variable<String>(settings.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('area: $area, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('settings: $settings, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, DocumentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorsMeta = const VerificationMeta(
    'authors',
  );
  @override
  late final GeneratedColumn<String> authors = GeneratedColumn<String>(
    'authors',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPagesMeta = const VerificationMeta(
    'totalPages',
  );
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
    'total_pages',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReadPageMeta = const VerificationMeta(
    'lastReadPage',
  );
  @override
  late final GeneratedColumn<int> lastReadPage = GeneratedColumn<int>(
    'last_read_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _processingStatusMeta = const VerificationMeta(
    'processingStatus',
  );
  @override
  late final GeneratedColumn<String> processingStatus = GeneratedColumn<String>(
    'processing_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('imported'),
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<int> importedAt = GeneratedColumn<int>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    fileName,
    filePath,
    title,
    authors,
    year,
    totalPages,
    lastReadPage,
    processingStatus,
    importedAt,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('authors')) {
      context.handle(
        _authorsMeta,
        authors.isAcceptableOrUnknown(data['authors']!, _authorsMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('total_pages')) {
      context.handle(
        _totalPagesMeta,
        totalPages.isAcceptableOrUnknown(data['total_pages']!, _totalPagesMeta),
      );
    }
    if (data.containsKey('last_read_page')) {
      context.handle(
        _lastReadPageMeta,
        lastReadPage.isAcceptableOrUnknown(
          data['last_read_page']!,
          _lastReadPageMeta,
        ),
      );
    }
    if (data.containsKey('processing_status')) {
      context.handle(
        _processingStatusMeta,
        processingStatus.isAcceptableOrUnknown(
          data['processing_status']!,
          _processingStatusMeta,
        ),
      );
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      authors: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}authors'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      totalPages: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pages'],
      ),
      lastReadPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_read_page'],
      )!,
      processingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_status'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_at'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class DocumentRow extends DataClass implements Insertable<DocumentRow> {
  final String id;
  final String projectId;
  final String fileName;
  final String filePath;
  final String? title;

  /// JSON array: ["Author A", "Author B"]
  final String? authors;
  final int? year;
  final int? totalPages;
  final int lastReadPage;

  /// imported | segmented | indexed | summarized | fully_processed
  final String processingStatus;
  final int importedAt;
  final String? metadata;
  const DocumentRow({
    required this.id,
    required this.projectId,
    required this.fileName,
    required this.filePath,
    this.title,
    this.authors,
    this.year,
    this.totalPages,
    required this.lastReadPage,
    required this.processingStatus,
    required this.importedAt,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['file_name'] = Variable<String>(fileName);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || authors != null) {
      map['authors'] = Variable<String>(authors);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || totalPages != null) {
      map['total_pages'] = Variable<int>(totalPages);
    }
    map['last_read_page'] = Variable<int>(lastReadPage);
    map['processing_status'] = Variable<String>(processingStatus);
    map['imported_at'] = Variable<int>(importedAt);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      fileName: Value(fileName),
      filePath: Value(filePath),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      authors: authors == null && nullToAbsent
          ? const Value.absent()
          : Value(authors),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      totalPages: totalPages == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPages),
      lastReadPage: Value(lastReadPage),
      processingStatus: Value(processingStatus),
      importedAt: Value(importedAt),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory DocumentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      filePath: serializer.fromJson<String>(json['filePath']),
      title: serializer.fromJson<String?>(json['title']),
      authors: serializer.fromJson<String?>(json['authors']),
      year: serializer.fromJson<int?>(json['year']),
      totalPages: serializer.fromJson<int?>(json['totalPages']),
      lastReadPage: serializer.fromJson<int>(json['lastReadPage']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
      importedAt: serializer.fromJson<int>(json['importedAt']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'fileName': serializer.toJson<String>(fileName),
      'filePath': serializer.toJson<String>(filePath),
      'title': serializer.toJson<String?>(title),
      'authors': serializer.toJson<String?>(authors),
      'year': serializer.toJson<int?>(year),
      'totalPages': serializer.toJson<int?>(totalPages),
      'lastReadPage': serializer.toJson<int>(lastReadPage),
      'processingStatus': serializer.toJson<String>(processingStatus),
      'importedAt': serializer.toJson<int>(importedAt),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  DocumentRow copyWith({
    String? id,
    String? projectId,
    String? fileName,
    String? filePath,
    Value<String?> title = const Value.absent(),
    Value<String?> authors = const Value.absent(),
    Value<int?> year = const Value.absent(),
    Value<int?> totalPages = const Value.absent(),
    int? lastReadPage,
    String? processingStatus,
    int? importedAt,
    Value<String?> metadata = const Value.absent(),
  }) => DocumentRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    fileName: fileName ?? this.fileName,
    filePath: filePath ?? this.filePath,
    title: title.present ? title.value : this.title,
    authors: authors.present ? authors.value : this.authors,
    year: year.present ? year.value : this.year,
    totalPages: totalPages.present ? totalPages.value : this.totalPages,
    lastReadPage: lastReadPage ?? this.lastReadPage,
    processingStatus: processingStatus ?? this.processingStatus,
    importedAt: importedAt ?? this.importedAt,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  DocumentRow copyWithCompanion(DocumentsCompanion data) {
    return DocumentRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      title: data.title.present ? data.title.value : this.title,
      authors: data.authors.present ? data.authors.value : this.authors,
      year: data.year.present ? data.year.value : this.year,
      totalPages: data.totalPages.present
          ? data.totalPages.value
          : this.totalPages,
      lastReadPage: data.lastReadPage.present
          ? data.lastReadPage.value
          : this.lastReadPage,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('year: $year, ')
          ..write('totalPages: $totalPages, ')
          ..write('lastReadPage: $lastReadPage, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('importedAt: $importedAt, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    fileName,
    filePath,
    title,
    authors,
    year,
    totalPages,
    lastReadPage,
    processingStatus,
    importedAt,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.fileName == this.fileName &&
          other.filePath == this.filePath &&
          other.title == this.title &&
          other.authors == this.authors &&
          other.year == this.year &&
          other.totalPages == this.totalPages &&
          other.lastReadPage == this.lastReadPage &&
          other.processingStatus == this.processingStatus &&
          other.importedAt == this.importedAt &&
          other.metadata == this.metadata);
}

class DocumentsCompanion extends UpdateCompanion<DocumentRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> fileName;
  final Value<String> filePath;
  final Value<String?> title;
  final Value<String?> authors;
  final Value<int?> year;
  final Value<int?> totalPages;
  final Value<int> lastReadPage;
  final Value<String> processingStatus;
  final Value<int> importedAt;
  final Value<String?> metadata;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.filePath = const Value.absent(),
    this.title = const Value.absent(),
    this.authors = const Value.absent(),
    this.year = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.lastReadPage = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    required String projectId,
    required String fileName,
    required String filePath,
    this.title = const Value.absent(),
    this.authors = const Value.absent(),
    this.year = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.lastReadPage = const Value.absent(),
    this.processingStatus = const Value.absent(),
    required int importedAt,
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       fileName = Value(fileName),
       filePath = Value(filePath),
       importedAt = Value(importedAt);
  static Insertable<DocumentRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? fileName,
    Expression<String>? filePath,
    Expression<String>? title,
    Expression<String>? authors,
    Expression<int>? year,
    Expression<int>? totalPages,
    Expression<int>? lastReadPage,
    Expression<String>? processingStatus,
    Expression<int>? importedAt,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (fileName != null) 'file_name': fileName,
      if (filePath != null) 'file_path': filePath,
      if (title != null) 'title': title,
      if (authors != null) 'authors': authors,
      if (year != null) 'year': year,
      if (totalPages != null) 'total_pages': totalPages,
      if (lastReadPage != null) 'last_read_page': lastReadPage,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (importedAt != null) 'imported_at': importedAt,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? fileName,
    Value<String>? filePath,
    Value<String?>? title,
    Value<String?>? authors,
    Value<int?>? year,
    Value<int?>? totalPages,
    Value<int>? lastReadPage,
    Value<String>? processingStatus,
    Value<int>? importedAt,
    Value<String?>? metadata,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      year: year ?? this.year,
      totalPages: totalPages ?? this.totalPages,
      lastReadPage: lastReadPage ?? this.lastReadPage,
      processingStatus: processingStatus ?? this.processingStatus,
      importedAt: importedAt ?? this.importedAt,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (authors.present) {
      map['authors'] = Variable<String>(authors.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (lastReadPage.present) {
      map['last_read_page'] = Variable<int>(lastReadPage.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = Variable<String>(processingStatus.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<int>(importedAt.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('year: $year, ')
          ..write('totalPages: $totalPages, ')
          ..write('lastReadPage: $lastReadPage, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('importedAt: $importedAt, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PageContentsTable extends PageContents
    with TableInfo<$PageContentsTable, PageContentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PageContentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('extraction'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    pageNumber,
    content,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'page_contents';
  @override
  VerificationContext validateIntegrity(
    Insertable<PageContentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {documentId, pageNumber},
  ];
  @override
  PageContentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PageContentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      pageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_number'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $PageContentsTable createAlias(String alias) {
    return $PageContentsTable(attachedDatabase, alias);
  }
}

class PageContentRow extends DataClass implements Insertable<PageContentRow> {
  final String id;
  final String documentId;
  final int pageNumber;
  final String content;

  /// 'extraction' | 'ocr'
  final String source;
  const PageContentRow({
    required this.id,
    required this.documentId,
    required this.pageNumber,
    required this.content,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['page_number'] = Variable<int>(pageNumber);
    map['content'] = Variable<String>(content);
    map['source'] = Variable<String>(source);
    return map;
  }

  PageContentsCompanion toCompanion(bool nullToAbsent) {
    return PageContentsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      pageNumber: Value(pageNumber),
      content: Value(content),
      source: Value(source),
    );
  }

  factory PageContentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PageContentRow(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      content: serializer.fromJson<String>(json['content']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'content': serializer.toJson<String>(content),
      'source': serializer.toJson<String>(source),
    };
  }

  PageContentRow copyWith({
    String? id,
    String? documentId,
    int? pageNumber,
    String? content,
    String? source,
  }) => PageContentRow(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    pageNumber: pageNumber ?? this.pageNumber,
    content: content ?? this.content,
    source: source ?? this.source,
  );
  PageContentRow copyWithCompanion(PageContentsCompanion data) {
    return PageContentRow(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      pageNumber: data.pageNumber.present
          ? data.pageNumber.value
          : this.pageNumber,
      content: data.content.present ? data.content.value : this.content,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PageContentRow(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('content: $content, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, documentId, pageNumber, content, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PageContentRow &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.pageNumber == this.pageNumber &&
          other.content == this.content &&
          other.source == this.source);
}

class PageContentsCompanion extends UpdateCompanion<PageContentRow> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> pageNumber;
  final Value<String> content;
  final Value<String> source;
  final Value<int> rowid;
  const PageContentsCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.content = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PageContentsCompanion.insert({
    required String id,
    required String documentId,
    required int pageNumber,
    required String content,
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       pageNumber = Value(pageNumber),
       content = Value(content);
  static Insertable<PageContentRow> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? pageNumber,
    Expression<String>? content,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (pageNumber != null) 'page_number': pageNumber,
      if (content != null) 'content': content,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PageContentsCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? pageNumber,
    Value<String>? content,
    Value<String>? source,
    Value<int>? rowid,
  }) {
    return PageContentsCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      pageNumber: pageNumber ?? this.pageNumber,
      content: content ?? this.content,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PageContentsCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('content: $content, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParagraphsTable extends Paragraphs
    with TableInfo<$ParagraphsTable, ParagraphRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParagraphsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paragraphIndexMeta = const VerificationMeta(
    'paragraphIndex',
  );
  @override
  late final GeneratedColumn<int> paragraphIndex = GeneratedColumn<int>(
    'paragraph_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _compressedTextMeta = const VerificationMeta(
    'compressedText',
  );
  @override
  late final GeneratedColumn<String> compressedText = GeneratedColumn<String>(
    'compressed_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    pageNumber,
    paragraphIndex,
    content,
    compressedText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paragraphs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParagraphRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('paragraph_index')) {
      context.handle(
        _paragraphIndexMeta,
        paragraphIndex.isAcceptableOrUnknown(
          data['paragraph_index']!,
          _paragraphIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paragraphIndexMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('compressed_text')) {
      context.handle(
        _compressedTextMeta,
        compressedText.isAcceptableOrUnknown(
          data['compressed_text']!,
          _compressedTextMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {documentId, pageNumber, paragraphIndex},
  ];
  @override
  ParagraphRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParagraphRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      pageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_number'],
      )!,
      paragraphIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paragraph_index'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      compressedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compressed_text'],
      ),
    );
  }

  @override
  $ParagraphsTable createAlias(String alias) {
    return $ParagraphsTable(attachedDatabase, alias);
  }
}

class ParagraphRow extends DataClass implements Insertable<ParagraphRow> {
  final String id;
  final String documentId;
  final int pageNumber;
  final int paragraphIndex;
  final String content;

  /// Generated on demand by TextCompressor.
  final String? compressedText;
  const ParagraphRow({
    required this.id,
    required this.documentId,
    required this.pageNumber,
    required this.paragraphIndex,
    required this.content,
    this.compressedText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['page_number'] = Variable<int>(pageNumber);
    map['paragraph_index'] = Variable<int>(paragraphIndex);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || compressedText != null) {
      map['compressed_text'] = Variable<String>(compressedText);
    }
    return map;
  }

  ParagraphsCompanion toCompanion(bool nullToAbsent) {
    return ParagraphsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      pageNumber: Value(pageNumber),
      paragraphIndex: Value(paragraphIndex),
      content: Value(content),
      compressedText: compressedText == null && nullToAbsent
          ? const Value.absent()
          : Value(compressedText),
    );
  }

  factory ParagraphRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParagraphRow(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      paragraphIndex: serializer.fromJson<int>(json['paragraphIndex']),
      content: serializer.fromJson<String>(json['content']),
      compressedText: serializer.fromJson<String?>(json['compressedText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'paragraphIndex': serializer.toJson<int>(paragraphIndex),
      'content': serializer.toJson<String>(content),
      'compressedText': serializer.toJson<String?>(compressedText),
    };
  }

  ParagraphRow copyWith({
    String? id,
    String? documentId,
    int? pageNumber,
    int? paragraphIndex,
    String? content,
    Value<String?> compressedText = const Value.absent(),
  }) => ParagraphRow(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    pageNumber: pageNumber ?? this.pageNumber,
    paragraphIndex: paragraphIndex ?? this.paragraphIndex,
    content: content ?? this.content,
    compressedText: compressedText.present
        ? compressedText.value
        : this.compressedText,
  );
  ParagraphRow copyWithCompanion(ParagraphsCompanion data) {
    return ParagraphRow(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      pageNumber: data.pageNumber.present
          ? data.pageNumber.value
          : this.pageNumber,
      paragraphIndex: data.paragraphIndex.present
          ? data.paragraphIndex.value
          : this.paragraphIndex,
      content: data.content.present ? data.content.value : this.content,
      compressedText: data.compressedText.present
          ? data.compressedText.value
          : this.compressedText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParagraphRow(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('paragraphIndex: $paragraphIndex, ')
          ..write('content: $content, ')
          ..write('compressedText: $compressedText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    pageNumber,
    paragraphIndex,
    content,
    compressedText,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParagraphRow &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.pageNumber == this.pageNumber &&
          other.paragraphIndex == this.paragraphIndex &&
          other.content == this.content &&
          other.compressedText == this.compressedText);
}

class ParagraphsCompanion extends UpdateCompanion<ParagraphRow> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> pageNumber;
  final Value<int> paragraphIndex;
  final Value<String> content;
  final Value<String?> compressedText;
  final Value<int> rowid;
  const ParagraphsCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.paragraphIndex = const Value.absent(),
    this.content = const Value.absent(),
    this.compressedText = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParagraphsCompanion.insert({
    required String id,
    required String documentId,
    required int pageNumber,
    required int paragraphIndex,
    required String content,
    this.compressedText = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       pageNumber = Value(pageNumber),
       paragraphIndex = Value(paragraphIndex),
       content = Value(content);
  static Insertable<ParagraphRow> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? pageNumber,
    Expression<int>? paragraphIndex,
    Expression<String>? content,
    Expression<String>? compressedText,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (pageNumber != null) 'page_number': pageNumber,
      if (paragraphIndex != null) 'paragraph_index': paragraphIndex,
      if (content != null) 'content': content,
      if (compressedText != null) 'compressed_text': compressedText,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParagraphsCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? pageNumber,
    Value<int>? paragraphIndex,
    Value<String>? content,
    Value<String?>? compressedText,
    Value<int>? rowid,
  }) {
    return ParagraphsCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      pageNumber: pageNumber ?? this.pageNumber,
      paragraphIndex: paragraphIndex ?? this.paragraphIndex,
      content: content ?? this.content,
      compressedText: compressedText ?? this.compressedText,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (paragraphIndex.present) {
      map['paragraph_index'] = Variable<int>(paragraphIndex.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (compressedText.present) {
      map['compressed_text'] = Variable<String>(compressedText.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParagraphsCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('paragraphIndex: $paragraphIndex, ')
          ..write('content: $content, ')
          ..write('compressedText: $compressedText, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParagraphEmbeddingsTable extends ParagraphEmbeddings
    with TableInfo<$ParagraphEmbeddingsTable, ParagraphEmbeddingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParagraphEmbeddingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paragraphIdMeta = const VerificationMeta(
    'paragraphId',
  );
  @override
  late final GeneratedColumn<String> paragraphId = GeneratedColumn<String>(
    'paragraph_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES paragraphs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _embeddingMeta = const VerificationMeta(
    'embedding',
  );
  @override
  late final GeneratedColumn<Uint8List> embedding = GeneratedColumn<Uint8List>(
    'embedding',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dimensionsMeta = const VerificationMeta(
    'dimensions',
  );
  @override
  late final GeneratedColumn<int> dimensions = GeneratedColumn<int>(
    'dimensions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    paragraphId,
    embedding,
    model,
    dimensions,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paragraph_embeddings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParagraphEmbeddingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('paragraph_id')) {
      context.handle(
        _paragraphIdMeta,
        paragraphId.isAcceptableOrUnknown(
          data['paragraph_id']!,
          _paragraphIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paragraphIdMeta);
    }
    if (data.containsKey('embedding')) {
      context.handle(
        _embeddingMeta,
        embedding.isAcceptableOrUnknown(data['embedding']!, _embeddingMeta),
      );
    } else if (isInserting) {
      context.missing(_embeddingMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('dimensions')) {
      context.handle(
        _dimensionsMeta,
        dimensions.isAcceptableOrUnknown(data['dimensions']!, _dimensionsMeta),
      );
    } else if (isInserting) {
      context.missing(_dimensionsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParagraphEmbeddingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParagraphEmbeddingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      paragraphId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paragraph_id'],
      )!,
      embedding: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}embedding'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      dimensions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dimensions'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ParagraphEmbeddingsTable createAlias(String alias) {
    return $ParagraphEmbeddingsTable(attachedDatabase, alias);
  }
}

class ParagraphEmbeddingRow extends DataClass
    implements Insertable<ParagraphEmbeddingRow> {
  final String id;
  final String paragraphId;

  /// float32[] serialized.
  final Uint8List embedding;
  final String model;
  final int dimensions;
  final int createdAt;
  const ParagraphEmbeddingRow({
    required this.id,
    required this.paragraphId,
    required this.embedding,
    required this.model,
    required this.dimensions,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['paragraph_id'] = Variable<String>(paragraphId);
    map['embedding'] = Variable<Uint8List>(embedding);
    map['model'] = Variable<String>(model);
    map['dimensions'] = Variable<int>(dimensions);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ParagraphEmbeddingsCompanion toCompanion(bool nullToAbsent) {
    return ParagraphEmbeddingsCompanion(
      id: Value(id),
      paragraphId: Value(paragraphId),
      embedding: Value(embedding),
      model: Value(model),
      dimensions: Value(dimensions),
      createdAt: Value(createdAt),
    );
  }

  factory ParagraphEmbeddingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParagraphEmbeddingRow(
      id: serializer.fromJson<String>(json['id']),
      paragraphId: serializer.fromJson<String>(json['paragraphId']),
      embedding: serializer.fromJson<Uint8List>(json['embedding']),
      model: serializer.fromJson<String>(json['model']),
      dimensions: serializer.fromJson<int>(json['dimensions']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'paragraphId': serializer.toJson<String>(paragraphId),
      'embedding': serializer.toJson<Uint8List>(embedding),
      'model': serializer.toJson<String>(model),
      'dimensions': serializer.toJson<int>(dimensions),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ParagraphEmbeddingRow copyWith({
    String? id,
    String? paragraphId,
    Uint8List? embedding,
    String? model,
    int? dimensions,
    int? createdAt,
  }) => ParagraphEmbeddingRow(
    id: id ?? this.id,
    paragraphId: paragraphId ?? this.paragraphId,
    embedding: embedding ?? this.embedding,
    model: model ?? this.model,
    dimensions: dimensions ?? this.dimensions,
    createdAt: createdAt ?? this.createdAt,
  );
  ParagraphEmbeddingRow copyWithCompanion(ParagraphEmbeddingsCompanion data) {
    return ParagraphEmbeddingRow(
      id: data.id.present ? data.id.value : this.id,
      paragraphId: data.paragraphId.present
          ? data.paragraphId.value
          : this.paragraphId,
      embedding: data.embedding.present ? data.embedding.value : this.embedding,
      model: data.model.present ? data.model.value : this.model,
      dimensions: data.dimensions.present
          ? data.dimensions.value
          : this.dimensions,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParagraphEmbeddingRow(')
          ..write('id: $id, ')
          ..write('paragraphId: $paragraphId, ')
          ..write('embedding: $embedding, ')
          ..write('model: $model, ')
          ..write('dimensions: $dimensions, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    paragraphId,
    $driftBlobEquality.hash(embedding),
    model,
    dimensions,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParagraphEmbeddingRow &&
          other.id == this.id &&
          other.paragraphId == this.paragraphId &&
          $driftBlobEquality.equals(other.embedding, this.embedding) &&
          other.model == this.model &&
          other.dimensions == this.dimensions &&
          other.createdAt == this.createdAt);
}

class ParagraphEmbeddingsCompanion
    extends UpdateCompanion<ParagraphEmbeddingRow> {
  final Value<String> id;
  final Value<String> paragraphId;
  final Value<Uint8List> embedding;
  final Value<String> model;
  final Value<int> dimensions;
  final Value<int> createdAt;
  final Value<int> rowid;
  const ParagraphEmbeddingsCompanion({
    this.id = const Value.absent(),
    this.paragraphId = const Value.absent(),
    this.embedding = const Value.absent(),
    this.model = const Value.absent(),
    this.dimensions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParagraphEmbeddingsCompanion.insert({
    required String id,
    required String paragraphId,
    required Uint8List embedding,
    required String model,
    required int dimensions,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       paragraphId = Value(paragraphId),
       embedding = Value(embedding),
       model = Value(model),
       dimensions = Value(dimensions),
       createdAt = Value(createdAt);
  static Insertable<ParagraphEmbeddingRow> custom({
    Expression<String>? id,
    Expression<String>? paragraphId,
    Expression<Uint8List>? embedding,
    Expression<String>? model,
    Expression<int>? dimensions,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paragraphId != null) 'paragraph_id': paragraphId,
      if (embedding != null) 'embedding': embedding,
      if (model != null) 'model': model,
      if (dimensions != null) 'dimensions': dimensions,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParagraphEmbeddingsCompanion copyWith({
    Value<String>? id,
    Value<String>? paragraphId,
    Value<Uint8List>? embedding,
    Value<String>? model,
    Value<int>? dimensions,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return ParagraphEmbeddingsCompanion(
      id: id ?? this.id,
      paragraphId: paragraphId ?? this.paragraphId,
      embedding: embedding ?? this.embedding,
      model: model ?? this.model,
      dimensions: dimensions ?? this.dimensions,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (paragraphId.present) {
      map['paragraph_id'] = Variable<String>(paragraphId.value);
    }
    if (embedding.present) {
      map['embedding'] = Variable<Uint8List>(embedding.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (dimensions.present) {
      map['dimensions'] = Variable<int>(dimensions.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParagraphEmbeddingsCompanion(')
          ..write('id: $id, ')
          ..write('paragraphId: $paragraphId, ')
          ..write('embedding: $embedding, ')
          ..write('model: $model, ')
          ..write('dimensions: $dimensions, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentStructureTable extends DocumentStructure
    with TableInfo<$DocumentStructureTable, StructureRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentStructureTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES document_structure (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageStartMeta = const VerificationMeta(
    'pageStart',
  );
  @override
  late final GeneratedColumn<int> pageStart = GeneratedColumn<int>(
    'page_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageEndMeta = const VerificationMeta(
    'pageEnd',
  );
  @override
  late final GeneratedColumn<int> pageEnd = GeneratedColumn<int>(
    'page_end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _processingStatusMeta = const VerificationMeta(
    'processingStatus',
  );
  @override
  late final GeneratedColumn<String> processingStatus = GeneratedColumn<String>(
    'processing_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    parentId,
    level,
    title,
    pageStart,
    pageEnd,
    orderIndex,
    processingStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_structure';
  @override
  VerificationContext validateIntegrity(
    Insertable<StructureRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('page_start')) {
      context.handle(
        _pageStartMeta,
        pageStart.isAcceptableOrUnknown(data['page_start']!, _pageStartMeta),
      );
    } else if (isInserting) {
      context.missing(_pageStartMeta);
    }
    if (data.containsKey('page_end')) {
      context.handle(
        _pageEndMeta,
        pageEnd.isAcceptableOrUnknown(data['page_end']!, _pageEndMeta),
      );
    } else if (isInserting) {
      context.missing(_pageEndMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('processing_status')) {
      context.handle(
        _processingStatusMeta,
        processingStatus.isAcceptableOrUnknown(
          data['processing_status']!,
          _processingStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StructureRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StructureRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      pageStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_start'],
      )!,
      pageEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_end'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      processingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_status'],
      )!,
    );
  }

  @override
  $DocumentStructureTable createAlias(String alias) {
    return $DocumentStructureTable(attachedDatabase, alias);
  }
}

class StructureRow extends DataClass implements Insertable<StructureRow> {
  final String id;
  final String documentId;
  final String? parentId;

  /// 1=section, 2=chapter, 3=document
  final int level;
  final String? title;
  final int pageStart;
  final int pageEnd;
  final int orderIndex;

  /// pending | compressing | compressed | summarizing | done
  final String processingStatus;
  const StructureRow({
    required this.id,
    required this.documentId,
    this.parentId,
    required this.level,
    this.title,
    required this.pageStart,
    required this.pageEnd,
    required this.orderIndex,
    required this.processingStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['page_start'] = Variable<int>(pageStart);
    map['page_end'] = Variable<int>(pageEnd);
    map['order_index'] = Variable<int>(orderIndex);
    map['processing_status'] = Variable<String>(processingStatus);
    return map;
  }

  DocumentStructureCompanion toCompanion(bool nullToAbsent) {
    return DocumentStructureCompanion(
      id: Value(id),
      documentId: Value(documentId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      level: Value(level),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      pageStart: Value(pageStart),
      pageEnd: Value(pageEnd),
      orderIndex: Value(orderIndex),
      processingStatus: Value(processingStatus),
    );
  }

  factory StructureRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StructureRow(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      level: serializer.fromJson<int>(json['level']),
      title: serializer.fromJson<String?>(json['title']),
      pageStart: serializer.fromJson<int>(json['pageStart']),
      pageEnd: serializer.fromJson<int>(json['pageEnd']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'parentId': serializer.toJson<String?>(parentId),
      'level': serializer.toJson<int>(level),
      'title': serializer.toJson<String?>(title),
      'pageStart': serializer.toJson<int>(pageStart),
      'pageEnd': serializer.toJson<int>(pageEnd),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'processingStatus': serializer.toJson<String>(processingStatus),
    };
  }

  StructureRow copyWith({
    String? id,
    String? documentId,
    Value<String?> parentId = const Value.absent(),
    int? level,
    Value<String?> title = const Value.absent(),
    int? pageStart,
    int? pageEnd,
    int? orderIndex,
    String? processingStatus,
  }) => StructureRow(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    parentId: parentId.present ? parentId.value : this.parentId,
    level: level ?? this.level,
    title: title.present ? title.value : this.title,
    pageStart: pageStart ?? this.pageStart,
    pageEnd: pageEnd ?? this.pageEnd,
    orderIndex: orderIndex ?? this.orderIndex,
    processingStatus: processingStatus ?? this.processingStatus,
  );
  StructureRow copyWithCompanion(DocumentStructureCompanion data) {
    return StructureRow(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      level: data.level.present ? data.level.value : this.level,
      title: data.title.present ? data.title.value : this.title,
      pageStart: data.pageStart.present ? data.pageStart.value : this.pageStart,
      pageEnd: data.pageEnd.present ? data.pageEnd.value : this.pageEnd,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StructureRow(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('title: $title, ')
          ..write('pageStart: $pageStart, ')
          ..write('pageEnd: $pageEnd, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('processingStatus: $processingStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    parentId,
    level,
    title,
    pageStart,
    pageEnd,
    orderIndex,
    processingStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StructureRow &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.parentId == this.parentId &&
          other.level == this.level &&
          other.title == this.title &&
          other.pageStart == this.pageStart &&
          other.pageEnd == this.pageEnd &&
          other.orderIndex == this.orderIndex &&
          other.processingStatus == this.processingStatus);
}

class DocumentStructureCompanion extends UpdateCompanion<StructureRow> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String?> parentId;
  final Value<int> level;
  final Value<String?> title;
  final Value<int> pageStart;
  final Value<int> pageEnd;
  final Value<int> orderIndex;
  final Value<String> processingStatus;
  final Value<int> rowid;
  const DocumentStructureCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.level = const Value.absent(),
    this.title = const Value.absent(),
    this.pageStart = const Value.absent(),
    this.pageEnd = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentStructureCompanion.insert({
    required String id,
    required String documentId,
    this.parentId = const Value.absent(),
    required int level,
    this.title = const Value.absent(),
    required int pageStart,
    required int pageEnd,
    required int orderIndex,
    this.processingStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       level = Value(level),
       pageStart = Value(pageStart),
       pageEnd = Value(pageEnd),
       orderIndex = Value(orderIndex);
  static Insertable<StructureRow> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? parentId,
    Expression<int>? level,
    Expression<String>? title,
    Expression<int>? pageStart,
    Expression<int>? pageEnd,
    Expression<int>? orderIndex,
    Expression<String>? processingStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (parentId != null) 'parent_id': parentId,
      if (level != null) 'level': level,
      if (title != null) 'title': title,
      if (pageStart != null) 'page_start': pageStart,
      if (pageEnd != null) 'page_end': pageEnd,
      if (orderIndex != null) 'order_index': orderIndex,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentStructureCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String?>? parentId,
    Value<int>? level,
    Value<String?>? title,
    Value<int>? pageStart,
    Value<int>? pageEnd,
    Value<int>? orderIndex,
    Value<String>? processingStatus,
    Value<int>? rowid,
  }) {
    return DocumentStructureCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      parentId: parentId ?? this.parentId,
      level: level ?? this.level,
      title: title ?? this.title,
      pageStart: pageStart ?? this.pageStart,
      pageEnd: pageEnd ?? this.pageEnd,
      orderIndex: orderIndex ?? this.orderIndex,
      processingStatus: processingStatus ?? this.processingStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (pageStart.present) {
      map['page_start'] = Variable<int>(pageStart.value);
    }
    if (pageEnd.present) {
      map['page_end'] = Variable<int>(pageEnd.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = Variable<String>(processingStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentStructureCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('title: $title, ')
          ..write('pageStart: $pageStart, ')
          ..write('pageEnd: $pageEnd, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionSummariesTable extends SectionSummaries
    with TableInfo<$SectionSummariesTable, SectionSummaryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _structureIdMeta = const VerificationMeta(
    'structureId',
  );
  @override
  late final GeneratedColumn<String> structureId = GeneratedColumn<String>(
    'structure_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES document_structure (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _compressedTextMeta = const VerificationMeta(
    'compressedText',
  );
  @override
  late final GeneratedColumn<String> compressedText = GeneratedColumn<String>(
    'compressed_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keyConceptsMeta = const VerificationMeta(
    'keyConcepts',
  );
  @override
  late final GeneratedColumn<String> keyConcepts = GeneratedColumn<String>(
    'key_concepts',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inputTokensMeta = const VerificationMeta(
    'inputTokens',
  );
  @override
  late final GeneratedColumn<int> inputTokens = GeneratedColumn<int>(
    'input_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outputTokensMeta = const VerificationMeta(
    'outputTokens',
  );
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
    'output_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promptVersionMeta = const VerificationMeta(
    'promptVersion',
  );
  @override
  late final GeneratedColumn<String> promptVersion = GeneratedColumn<String>(
    'prompt_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<int> generatedAt = GeneratedColumn<int>(
    'generated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cacheHashMeta = const VerificationMeta(
    'cacheHash',
  );
  @override
  late final GeneratedColumn<String> cacheHash = GeneratedColumn<String>(
    'cache_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    structureId,
    compressedText,
    summary,
    keyConcepts,
    inputTokens,
    outputTokens,
    provider,
    model,
    promptVersion,
    generatedAt,
    cacheHash,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'section_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SectionSummaryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('structure_id')) {
      context.handle(
        _structureIdMeta,
        structureId.isAcceptableOrUnknown(
          data['structure_id']!,
          _structureIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_structureIdMeta);
    }
    if (data.containsKey('compressed_text')) {
      context.handle(
        _compressedTextMeta,
        compressedText.isAcceptableOrUnknown(
          data['compressed_text']!,
          _compressedTextMeta,
        ),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('key_concepts')) {
      context.handle(
        _keyConceptsMeta,
        keyConcepts.isAcceptableOrUnknown(
          data['key_concepts']!,
          _keyConceptsMeta,
        ),
      );
    }
    if (data.containsKey('input_tokens')) {
      context.handle(
        _inputTokensMeta,
        inputTokens.isAcceptableOrUnknown(
          data['input_tokens']!,
          _inputTokensMeta,
        ),
      );
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
        _outputTokensMeta,
        outputTokens.isAcceptableOrUnknown(
          data['output_tokens']!,
          _outputTokensMeta,
        ),
      );
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('prompt_version')) {
      context.handle(
        _promptVersionMeta,
        promptVersion.isAcceptableOrUnknown(
          data['prompt_version']!,
          _promptVersionMeta,
        ),
      );
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    }
    if (data.containsKey('cache_hash')) {
      context.handle(
        _cacheHashMeta,
        cacheHash.isAcceptableOrUnknown(data['cache_hash']!, _cacheHashMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SectionSummaryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionSummaryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      structureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}structure_id'],
      )!,
      compressedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compressed_text'],
      ),
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      keyConcepts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_concepts'],
      ),
      inputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_tokens'],
      ),
      outputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_tokens'],
      ),
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      promptVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_version'],
      ),
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generated_at'],
      ),
      cacheHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_hash'],
      ),
    );
  }

  @override
  $SectionSummariesTable createAlias(String alias) {
    return $SectionSummariesTable(attachedDatabase, alias);
  }
}

class SectionSummaryRow extends DataClass
    implements Insertable<SectionSummaryRow> {
  final String id;
  final String structureId;
  final String? compressedText;
  final String? summary;

  /// JSON array: ["concept1", "concept2"]
  final String? keyConcepts;
  final int? inputTokens;
  final int? outputTokens;
  final String? provider;
  final String? model;
  final String? promptVersion;
  final int? generatedAt;

  /// SHA-256 of compressed_text.
  final String? cacheHash;
  const SectionSummaryRow({
    required this.id,
    required this.structureId,
    this.compressedText,
    this.summary,
    this.keyConcepts,
    this.inputTokens,
    this.outputTokens,
    this.provider,
    this.model,
    this.promptVersion,
    this.generatedAt,
    this.cacheHash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['structure_id'] = Variable<String>(structureId);
    if (!nullToAbsent || compressedText != null) {
      map['compressed_text'] = Variable<String>(compressedText);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || keyConcepts != null) {
      map['key_concepts'] = Variable<String>(keyConcepts);
    }
    if (!nullToAbsent || inputTokens != null) {
      map['input_tokens'] = Variable<int>(inputTokens);
    }
    if (!nullToAbsent || outputTokens != null) {
      map['output_tokens'] = Variable<int>(outputTokens);
    }
    if (!nullToAbsent || provider != null) {
      map['provider'] = Variable<String>(provider);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || promptVersion != null) {
      map['prompt_version'] = Variable<String>(promptVersion);
    }
    if (!nullToAbsent || generatedAt != null) {
      map['generated_at'] = Variable<int>(generatedAt);
    }
    if (!nullToAbsent || cacheHash != null) {
      map['cache_hash'] = Variable<String>(cacheHash);
    }
    return map;
  }

  SectionSummariesCompanion toCompanion(bool nullToAbsent) {
    return SectionSummariesCompanion(
      id: Value(id),
      structureId: Value(structureId),
      compressedText: compressedText == null && nullToAbsent
          ? const Value.absent()
          : Value(compressedText),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      keyConcepts: keyConcepts == null && nullToAbsent
          ? const Value.absent()
          : Value(keyConcepts),
      inputTokens: inputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(inputTokens),
      outputTokens: outputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(outputTokens),
      provider: provider == null && nullToAbsent
          ? const Value.absent()
          : Value(provider),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      promptVersion: promptVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(promptVersion),
      generatedAt: generatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(generatedAt),
      cacheHash: cacheHash == null && nullToAbsent
          ? const Value.absent()
          : Value(cacheHash),
    );
  }

  factory SectionSummaryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionSummaryRow(
      id: serializer.fromJson<String>(json['id']),
      structureId: serializer.fromJson<String>(json['structureId']),
      compressedText: serializer.fromJson<String?>(json['compressedText']),
      summary: serializer.fromJson<String?>(json['summary']),
      keyConcepts: serializer.fromJson<String?>(json['keyConcepts']),
      inputTokens: serializer.fromJson<int?>(json['inputTokens']),
      outputTokens: serializer.fromJson<int?>(json['outputTokens']),
      provider: serializer.fromJson<String?>(json['provider']),
      model: serializer.fromJson<String?>(json['model']),
      promptVersion: serializer.fromJson<String?>(json['promptVersion']),
      generatedAt: serializer.fromJson<int?>(json['generatedAt']),
      cacheHash: serializer.fromJson<String?>(json['cacheHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'structureId': serializer.toJson<String>(structureId),
      'compressedText': serializer.toJson<String?>(compressedText),
      'summary': serializer.toJson<String?>(summary),
      'keyConcepts': serializer.toJson<String?>(keyConcepts),
      'inputTokens': serializer.toJson<int?>(inputTokens),
      'outputTokens': serializer.toJson<int?>(outputTokens),
      'provider': serializer.toJson<String?>(provider),
      'model': serializer.toJson<String?>(model),
      'promptVersion': serializer.toJson<String?>(promptVersion),
      'generatedAt': serializer.toJson<int?>(generatedAt),
      'cacheHash': serializer.toJson<String?>(cacheHash),
    };
  }

  SectionSummaryRow copyWith({
    String? id,
    String? structureId,
    Value<String?> compressedText = const Value.absent(),
    Value<String?> summary = const Value.absent(),
    Value<String?> keyConcepts = const Value.absent(),
    Value<int?> inputTokens = const Value.absent(),
    Value<int?> outputTokens = const Value.absent(),
    Value<String?> provider = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> promptVersion = const Value.absent(),
    Value<int?> generatedAt = const Value.absent(),
    Value<String?> cacheHash = const Value.absent(),
  }) => SectionSummaryRow(
    id: id ?? this.id,
    structureId: structureId ?? this.structureId,
    compressedText: compressedText.present
        ? compressedText.value
        : this.compressedText,
    summary: summary.present ? summary.value : this.summary,
    keyConcepts: keyConcepts.present ? keyConcepts.value : this.keyConcepts,
    inputTokens: inputTokens.present ? inputTokens.value : this.inputTokens,
    outputTokens: outputTokens.present ? outputTokens.value : this.outputTokens,
    provider: provider.present ? provider.value : this.provider,
    model: model.present ? model.value : this.model,
    promptVersion: promptVersion.present
        ? promptVersion.value
        : this.promptVersion,
    generatedAt: generatedAt.present ? generatedAt.value : this.generatedAt,
    cacheHash: cacheHash.present ? cacheHash.value : this.cacheHash,
  );
  SectionSummaryRow copyWithCompanion(SectionSummariesCompanion data) {
    return SectionSummaryRow(
      id: data.id.present ? data.id.value : this.id,
      structureId: data.structureId.present
          ? data.structureId.value
          : this.structureId,
      compressedText: data.compressedText.present
          ? data.compressedText.value
          : this.compressedText,
      summary: data.summary.present ? data.summary.value : this.summary,
      keyConcepts: data.keyConcepts.present
          ? data.keyConcepts.value
          : this.keyConcepts,
      inputTokens: data.inputTokens.present
          ? data.inputTokens.value
          : this.inputTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      provider: data.provider.present ? data.provider.value : this.provider,
      model: data.model.present ? data.model.value : this.model,
      promptVersion: data.promptVersion.present
          ? data.promptVersion.value
          : this.promptVersion,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      cacheHash: data.cacheHash.present ? data.cacheHash.value : this.cacheHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionSummaryRow(')
          ..write('id: $id, ')
          ..write('structureId: $structureId, ')
          ..write('compressedText: $compressedText, ')
          ..write('summary: $summary, ')
          ..write('keyConcepts: $keyConcepts, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('cacheHash: $cacheHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    structureId,
    compressedText,
    summary,
    keyConcepts,
    inputTokens,
    outputTokens,
    provider,
    model,
    promptVersion,
    generatedAt,
    cacheHash,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionSummaryRow &&
          other.id == this.id &&
          other.structureId == this.structureId &&
          other.compressedText == this.compressedText &&
          other.summary == this.summary &&
          other.keyConcepts == this.keyConcepts &&
          other.inputTokens == this.inputTokens &&
          other.outputTokens == this.outputTokens &&
          other.provider == this.provider &&
          other.model == this.model &&
          other.promptVersion == this.promptVersion &&
          other.generatedAt == this.generatedAt &&
          other.cacheHash == this.cacheHash);
}

class SectionSummariesCompanion extends UpdateCompanion<SectionSummaryRow> {
  final Value<String> id;
  final Value<String> structureId;
  final Value<String?> compressedText;
  final Value<String?> summary;
  final Value<String?> keyConcepts;
  final Value<int?> inputTokens;
  final Value<int?> outputTokens;
  final Value<String?> provider;
  final Value<String?> model;
  final Value<String?> promptVersion;
  final Value<int?> generatedAt;
  final Value<String?> cacheHash;
  final Value<int> rowid;
  const SectionSummariesCompanion({
    this.id = const Value.absent(),
    this.structureId = const Value.absent(),
    this.compressedText = const Value.absent(),
    this.summary = const Value.absent(),
    this.keyConcepts = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.cacheHash = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionSummariesCompanion.insert({
    required String id,
    required String structureId,
    this.compressedText = const Value.absent(),
    this.summary = const Value.absent(),
    this.keyConcepts = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.cacheHash = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       structureId = Value(structureId);
  static Insertable<SectionSummaryRow> custom({
    Expression<String>? id,
    Expression<String>? structureId,
    Expression<String>? compressedText,
    Expression<String>? summary,
    Expression<String>? keyConcepts,
    Expression<int>? inputTokens,
    Expression<int>? outputTokens,
    Expression<String>? provider,
    Expression<String>? model,
    Expression<String>? promptVersion,
    Expression<int>? generatedAt,
    Expression<String>? cacheHash,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (structureId != null) 'structure_id': structureId,
      if (compressedText != null) 'compressed_text': compressedText,
      if (summary != null) 'summary': summary,
      if (keyConcepts != null) 'key_concepts': keyConcepts,
      if (inputTokens != null) 'input_tokens': inputTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (provider != null) 'provider': provider,
      if (model != null) 'model': model,
      if (promptVersion != null) 'prompt_version': promptVersion,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (cacheHash != null) 'cache_hash': cacheHash,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionSummariesCompanion copyWith({
    Value<String>? id,
    Value<String>? structureId,
    Value<String?>? compressedText,
    Value<String?>? summary,
    Value<String?>? keyConcepts,
    Value<int?>? inputTokens,
    Value<int?>? outputTokens,
    Value<String?>? provider,
    Value<String?>? model,
    Value<String?>? promptVersion,
    Value<int?>? generatedAt,
    Value<String?>? cacheHash,
    Value<int>? rowid,
  }) {
    return SectionSummariesCompanion(
      id: id ?? this.id,
      structureId: structureId ?? this.structureId,
      compressedText: compressedText ?? this.compressedText,
      summary: summary ?? this.summary,
      keyConcepts: keyConcepts ?? this.keyConcepts,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      promptVersion: promptVersion ?? this.promptVersion,
      generatedAt: generatedAt ?? this.generatedAt,
      cacheHash: cacheHash ?? this.cacheHash,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (structureId.present) {
      map['structure_id'] = Variable<String>(structureId.value);
    }
    if (compressedText.present) {
      map['compressed_text'] = Variable<String>(compressedText.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (keyConcepts.present) {
      map['key_concepts'] = Variable<String>(keyConcepts.value);
    }
    if (inputTokens.present) {
      map['input_tokens'] = Variable<int>(inputTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (promptVersion.present) {
      map['prompt_version'] = Variable<String>(promptVersion.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<int>(generatedAt.value);
    }
    if (cacheHash.present) {
      map['cache_hash'] = Variable<String>(cacheHash.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionSummariesCompanion(')
          ..write('id: $id, ')
          ..write('structureId: $structureId, ')
          ..write('compressedText: $compressedText, ')
          ..write('summary: $summary, ')
          ..write('keyConcepts: $keyConcepts, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('cacheHash: $cacheHash, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnnotationsTable extends Annotations
    with TableInfo<$AnnotationsTable, AnnotationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnnotationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _selectedTextMeta = const VerificationMeta(
    'selectedText',
  );
  @override
  late final GeneratedColumn<String> selectedText = GeneratedColumn<String>(
    'selected_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    pageNumber,
    type,
    color,
    selectedText,
    content,
    position,
    tags,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'annotations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnnotationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('selected_text')) {
      context.handle(
        _selectedTextMeta,
        selectedText.isAcceptableOrUnknown(
          data['selected_text']!,
          _selectedTextMeta,
        ),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnnotationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnnotationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      pageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_number'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      selectedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_text'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AnnotationsTable createAlias(String alias) {
    return $AnnotationsTable(attachedDatabase, alias);
  }
}

class AnnotationRow extends DataClass implements Insertable<AnnotationRow> {
  final String id;
  final String documentId;
  final int pageNumber;

  /// 'highlight' | 'note' | 'bookmark' | 'question'
  final String type;

  /// Hex color: '#FFEB3B'
  final String? color;
  final String? selectedText;

  /// Markdown content.
  final String? content;

  /// JSON: SelectionPosition { startOffset, endOffset, rects }
  final String position;

  /// JSON array: ["tag1", "tag2"]
  final String? tags;
  final int createdAt;
  final int updatedAt;
  const AnnotationRow({
    required this.id,
    required this.documentId,
    required this.pageNumber,
    required this.type,
    this.color,
    this.selectedText,
    this.content,
    required this.position,
    this.tags,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['page_number'] = Variable<int>(pageNumber);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || selectedText != null) {
      map['selected_text'] = Variable<String>(selectedText);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['position'] = Variable<String>(position);
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  AnnotationsCompanion toCompanion(bool nullToAbsent) {
    return AnnotationsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      pageNumber: Value(pageNumber),
      type: Value(type),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      selectedText: selectedText == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedText),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      position: Value(position),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AnnotationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnnotationRow(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      type: serializer.fromJson<String>(json['type']),
      color: serializer.fromJson<String?>(json['color']),
      selectedText: serializer.fromJson<String?>(json['selectedText']),
      content: serializer.fromJson<String?>(json['content']),
      position: serializer.fromJson<String>(json['position']),
      tags: serializer.fromJson<String?>(json['tags']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'type': serializer.toJson<String>(type),
      'color': serializer.toJson<String?>(color),
      'selectedText': serializer.toJson<String?>(selectedText),
      'content': serializer.toJson<String?>(content),
      'position': serializer.toJson<String>(position),
      'tags': serializer.toJson<String?>(tags),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  AnnotationRow copyWith({
    String? id,
    String? documentId,
    int? pageNumber,
    String? type,
    Value<String?> color = const Value.absent(),
    Value<String?> selectedText = const Value.absent(),
    Value<String?> content = const Value.absent(),
    String? position,
    Value<String?> tags = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => AnnotationRow(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    pageNumber: pageNumber ?? this.pageNumber,
    type: type ?? this.type,
    color: color.present ? color.value : this.color,
    selectedText: selectedText.present ? selectedText.value : this.selectedText,
    content: content.present ? content.value : this.content,
    position: position ?? this.position,
    tags: tags.present ? tags.value : this.tags,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AnnotationRow copyWithCompanion(AnnotationsCompanion data) {
    return AnnotationRow(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      pageNumber: data.pageNumber.present
          ? data.pageNumber.value
          : this.pageNumber,
      type: data.type.present ? data.type.value : this.type,
      color: data.color.present ? data.color.value : this.color,
      selectedText: data.selectedText.present
          ? data.selectedText.value
          : this.selectedText,
      content: data.content.present ? data.content.value : this.content,
      position: data.position.present ? data.position.value : this.position,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationRow(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('type: $type, ')
          ..write('color: $color, ')
          ..write('selectedText: $selectedText, ')
          ..write('content: $content, ')
          ..write('position: $position, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    pageNumber,
    type,
    color,
    selectedText,
    content,
    position,
    tags,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnnotationRow &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.pageNumber == this.pageNumber &&
          other.type == this.type &&
          other.color == this.color &&
          other.selectedText == this.selectedText &&
          other.content == this.content &&
          other.position == this.position &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AnnotationsCompanion extends UpdateCompanion<AnnotationRow> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> pageNumber;
  final Value<String> type;
  final Value<String?> color;
  final Value<String?> selectedText;
  final Value<String?> content;
  final Value<String> position;
  final Value<String?> tags;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const AnnotationsCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.type = const Value.absent(),
    this.color = const Value.absent(),
    this.selectedText = const Value.absent(),
    this.content = const Value.absent(),
    this.position = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnnotationsCompanion.insert({
    required String id,
    required String documentId,
    required int pageNumber,
    required String type,
    this.color = const Value.absent(),
    this.selectedText = const Value.absent(),
    this.content = const Value.absent(),
    required String position,
    this.tags = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       pageNumber = Value(pageNumber),
       type = Value(type),
       position = Value(position),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AnnotationRow> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? pageNumber,
    Expression<String>? type,
    Expression<String>? color,
    Expression<String>? selectedText,
    Expression<String>? content,
    Expression<String>? position,
    Expression<String>? tags,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (pageNumber != null) 'page_number': pageNumber,
      if (type != null) 'type': type,
      if (color != null) 'color': color,
      if (selectedText != null) 'selected_text': selectedText,
      if (content != null) 'content': content,
      if (position != null) 'position': position,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnnotationsCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? pageNumber,
    Value<String>? type,
    Value<String?>? color,
    Value<String?>? selectedText,
    Value<String?>? content,
    Value<String>? position,
    Value<String?>? tags,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return AnnotationsCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      pageNumber: pageNumber ?? this.pageNumber,
      type: type ?? this.type,
      color: color ?? this.color,
      selectedText: selectedText ?? this.selectedText,
      content: content ?? this.content,
      position: position ?? this.position,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (selectedText.present) {
      map['selected_text'] = Variable<String>(selectedText.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationsCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('type: $type, ')
          ..write('color: $color, ')
          ..write('selectedText: $selectedText, ')
          ..write('content: $content, ')
          ..write('position: $position, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnnotationVersionsTable extends AnnotationVersions
    with TableInfo<$AnnotationVersionsTable, AnnotationVersionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnnotationVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _annotationIdMeta = const VerificationMeta(
    'annotationId',
  );
  @override
  late final GeneratedColumn<String> annotationId = GeneratedColumn<String>(
    'annotation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES annotations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<int> changedAt = GeneratedColumn<int>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, annotationId, content, changedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'annotation_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnnotationVersionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('annotation_id')) {
      context.handle(
        _annotationIdMeta,
        annotationId.isAcceptableOrUnknown(
          data['annotation_id']!,
          _annotationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_annotationIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnnotationVersionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnnotationVersionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      annotationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}annotation_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}changed_at'],
      )!,
    );
  }

  @override
  $AnnotationVersionsTable createAlias(String alias) {
    return $AnnotationVersionsTable(attachedDatabase, alias);
  }
}

class AnnotationVersionRow extends DataClass
    implements Insertable<AnnotationVersionRow> {
  final String id;
  final String annotationId;
  final String content;
  final int changedAt;
  const AnnotationVersionRow({
    required this.id,
    required this.annotationId,
    required this.content,
    required this.changedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['annotation_id'] = Variable<String>(annotationId);
    map['content'] = Variable<String>(content);
    map['changed_at'] = Variable<int>(changedAt);
    return map;
  }

  AnnotationVersionsCompanion toCompanion(bool nullToAbsent) {
    return AnnotationVersionsCompanion(
      id: Value(id),
      annotationId: Value(annotationId),
      content: Value(content),
      changedAt: Value(changedAt),
    );
  }

  factory AnnotationVersionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnnotationVersionRow(
      id: serializer.fromJson<String>(json['id']),
      annotationId: serializer.fromJson<String>(json['annotationId']),
      content: serializer.fromJson<String>(json['content']),
      changedAt: serializer.fromJson<int>(json['changedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'annotationId': serializer.toJson<String>(annotationId),
      'content': serializer.toJson<String>(content),
      'changedAt': serializer.toJson<int>(changedAt),
    };
  }

  AnnotationVersionRow copyWith({
    String? id,
    String? annotationId,
    String? content,
    int? changedAt,
  }) => AnnotationVersionRow(
    id: id ?? this.id,
    annotationId: annotationId ?? this.annotationId,
    content: content ?? this.content,
    changedAt: changedAt ?? this.changedAt,
  );
  AnnotationVersionRow copyWithCompanion(AnnotationVersionsCompanion data) {
    return AnnotationVersionRow(
      id: data.id.present ? data.id.value : this.id,
      annotationId: data.annotationId.present
          ? data.annotationId.value
          : this.annotationId,
      content: data.content.present ? data.content.value : this.content,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationVersionRow(')
          ..write('id: $id, ')
          ..write('annotationId: $annotationId, ')
          ..write('content: $content, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, annotationId, content, changedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnnotationVersionRow &&
          other.id == this.id &&
          other.annotationId == this.annotationId &&
          other.content == this.content &&
          other.changedAt == this.changedAt);
}

class AnnotationVersionsCompanion
    extends UpdateCompanion<AnnotationVersionRow> {
  final Value<String> id;
  final Value<String> annotationId;
  final Value<String> content;
  final Value<int> changedAt;
  final Value<int> rowid;
  const AnnotationVersionsCompanion({
    this.id = const Value.absent(),
    this.annotationId = const Value.absent(),
    this.content = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnnotationVersionsCompanion.insert({
    required String id,
    required String annotationId,
    required String content,
    required int changedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       annotationId = Value(annotationId),
       content = Value(content),
       changedAt = Value(changedAt);
  static Insertable<AnnotationVersionRow> custom({
    Expression<String>? id,
    Expression<String>? annotationId,
    Expression<String>? content,
    Expression<int>? changedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (annotationId != null) 'annotation_id': annotationId,
      if (content != null) 'content': content,
      if (changedAt != null) 'changed_at': changedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnnotationVersionsCompanion copyWith({
    Value<String>? id,
    Value<String>? annotationId,
    Value<String>? content,
    Value<int>? changedAt,
    Value<int>? rowid,
  }) {
    return AnnotationVersionsCompanion(
      id: id ?? this.id,
      annotationId: annotationId ?? this.annotationId,
      content: content ?? this.content,
      changedAt: changedAt ?? this.changedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (annotationId.present) {
      map['annotation_id'] = Variable<String>(annotationId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<int>(changedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnnotationVersionsCompanion(')
          ..write('id: $id, ')
          ..write('annotationId: $annotationId, ')
          ..write('content: $content, ')
          ..write('changedAt: $changedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotebooksTable extends Notebooks
    with TableInfo<$NotebooksTable, NotebookRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotebooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    documentId,
    title,
    content,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notebooks';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotebookRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotebookRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotebookRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotebooksTable createAlias(String alias) {
    return $NotebooksTable(attachedDatabase, alias);
  }
}

class NotebookRow extends DataClass implements Insertable<NotebookRow> {
  final String id;
  final String projectId;

  /// Null = project-level notebook.
  final String? documentId;
  final String title;
  final String content;
  final int createdAt;
  final int updatedAt;
  const NotebookRow({
    required this.id,
    required this.projectId,
    this.documentId,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<String>(documentId);
    }
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  NotebooksCompanion toCompanion(bool nullToAbsent) {
    return NotebooksCompanion(
      id: Value(id),
      projectId: Value(projectId),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotebookRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotebookRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      documentId: serializer.fromJson<String?>(json['documentId']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'documentId': serializer.toJson<String?>(documentId),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  NotebookRow copyWith({
    String? id,
    String? projectId,
    Value<String?> documentId = const Value.absent(),
    String? title,
    String? content,
    int? createdAt,
    int? updatedAt,
  }) => NotebookRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    documentId: documentId.present ? documentId.value : this.documentId,
    title: title ?? this.title,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotebookRow copyWithCompanion(NotebooksCompanion data) {
    return NotebookRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotebookRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('documentId: $documentId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    documentId,
    title,
    content,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotebookRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.documentId == this.documentId &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotebooksCompanion extends UpdateCompanion<NotebookRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String?> documentId;
  final Value<String> title;
  final Value<String> content;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const NotebooksCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotebooksCompanion.insert({
    required String id,
    required String projectId,
    this.documentId = const Value.absent(),
    required String title,
    this.content = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NotebookRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? documentId,
    Expression<String>? title,
    Expression<String>? content,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (documentId != null) 'document_id': documentId,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotebooksCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String?>? documentId,
    Value<String>? title,
    Value<String>? content,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotebooksCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      documentId: documentId ?? this.documentId,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotebooksCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('documentId: $documentId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConceptsTable extends Concepts
    with TableInfo<$ConceptsTable, ConceptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConceptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    name,
    definition,
    type,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'concepts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConceptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConceptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConceptRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ConceptsTable createAlias(String alias) {
    return $ConceptsTable(attachedDatabase, alias);
  }
}

class ConceptRow extends DataClass implements Insertable<ConceptRow> {
  final String id;
  final String projectId;
  final String name;
  final String? definition;

  /// 'theoretical' | 'methodological' | 'empirical' | 'person' | 'event' | 'place'
  final String? type;

  /// 'user' | 'ai'
  final String source;
  final int createdAt;
  const ConceptRow({
    required this.id,
    required this.projectId,
    required this.name,
    this.definition,
    this.type,
    required this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || definition != null) {
      map['definition'] = Variable<String>(definition);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ConceptsCompanion toCompanion(bool nullToAbsent) {
    return ConceptsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      name: Value(name),
      definition: definition == null && nullToAbsent
          ? const Value.absent()
          : Value(definition),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      source: Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory ConceptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConceptRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      name: serializer.fromJson<String>(json['name']),
      definition: serializer.fromJson<String?>(json['definition']),
      type: serializer.fromJson<String?>(json['type']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'name': serializer.toJson<String>(name),
      'definition': serializer.toJson<String?>(definition),
      'type': serializer.toJson<String?>(type),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ConceptRow copyWith({
    String? id,
    String? projectId,
    String? name,
    Value<String?> definition = const Value.absent(),
    Value<String?> type = const Value.absent(),
    String? source,
    int? createdAt,
  }) => ConceptRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    name: name ?? this.name,
    definition: definition.present ? definition.value : this.definition,
    type: type.present ? type.value : this.type,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  ConceptRow copyWithCompanion(ConceptsCompanion data) {
    return ConceptRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      name: data.name.present ? data.name.value : this.name,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      type: data.type.present ? data.type.value : this.type,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConceptRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('definition: $definition, ')
          ..write('type: $type, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, name, definition, type, source, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConceptRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.name == this.name &&
          other.definition == this.definition &&
          other.type == this.type &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class ConceptsCompanion extends UpdateCompanion<ConceptRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> name;
  final Value<String?> definition;
  final Value<String?> type;
  final Value<String> source;
  final Value<int> createdAt;
  final Value<int> rowid;
  const ConceptsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.name = const Value.absent(),
    this.definition = const Value.absent(),
    this.type = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConceptsCompanion.insert({
    required String id,
    required String projectId,
    required String name,
    this.definition = const Value.absent(),
    this.type = const Value.absent(),
    required String source,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       name = Value(name),
       source = Value(source),
       createdAt = Value(createdAt);
  static Insertable<ConceptRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? name,
    Expression<String>? definition,
    Expression<String>? type,
    Expression<String>? source,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (name != null) 'name': name,
      if (definition != null) 'definition': definition,
      if (type != null) 'type': type,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConceptsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? name,
    Value<String?>? definition,
    Value<String?>? type,
    Value<String>? source,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return ConceptsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      definition: definition ?? this.definition,
      type: type ?? this.type,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConceptsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('definition: $definition, ')
          ..write('type: $type, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConceptRelationsTable extends ConceptRelations
    with TableInfo<$ConceptRelationsTable, ConceptRelationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConceptRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES concepts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _targetIdMeta = const VerificationMeta(
    'targetId',
  );
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
    'target_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES concepts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relationMeta = const VerificationMeta(
    'relation',
  );
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
    'relation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    sourceId,
    targetId,
    relation,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'concept_relations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConceptRelationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(
        _targetIdMeta,
        targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('relation')) {
      context.handle(
        _relationMeta,
        relation.isAcceptableOrUnknown(data['relation']!, _relationMeta),
      );
    } else if (isInserting) {
      context.missing(_relationMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sourceId, targetId, relation},
  ];
  @override
  ConceptRelationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConceptRelationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      targetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_id'],
      )!,
      relation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ConceptRelationsTable createAlias(String alias) {
    return $ConceptRelationsTable(attachedDatabase, alias);
  }
}

class ConceptRelationRow extends DataClass
    implements Insertable<ConceptRelationRow> {
  final String id;
  final String projectId;
  final String sourceId;
  final String targetId;

  /// 'defines' | 'contradicts' | 'supports' | 'exemplifies' | 'precedes'
  final String relation;
  final String? description;
  final int createdAt;
  const ConceptRelationRow({
    required this.id,
    required this.projectId,
    required this.sourceId,
    required this.targetId,
    required this.relation,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['source_id'] = Variable<String>(sourceId);
    map['target_id'] = Variable<String>(targetId);
    map['relation'] = Variable<String>(relation);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ConceptRelationsCompanion toCompanion(bool nullToAbsent) {
    return ConceptRelationsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      sourceId: Value(sourceId),
      targetId: Value(targetId),
      relation: Value(relation),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory ConceptRelationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConceptRelationRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      targetId: serializer.fromJson<String>(json['targetId']),
      relation: serializer.fromJson<String>(json['relation']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'sourceId': serializer.toJson<String>(sourceId),
      'targetId': serializer.toJson<String>(targetId),
      'relation': serializer.toJson<String>(relation),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ConceptRelationRow copyWith({
    String? id,
    String? projectId,
    String? sourceId,
    String? targetId,
    String? relation,
    Value<String?> description = const Value.absent(),
    int? createdAt,
  }) => ConceptRelationRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    sourceId: sourceId ?? this.sourceId,
    targetId: targetId ?? this.targetId,
    relation: relation ?? this.relation,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  ConceptRelationRow copyWithCompanion(ConceptRelationsCompanion data) {
    return ConceptRelationRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      relation: data.relation.present ? data.relation.value : this.relation,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConceptRelationRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('relation: $relation, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    sourceId,
    targetId,
    relation,
    description,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConceptRelationRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.sourceId == this.sourceId &&
          other.targetId == this.targetId &&
          other.relation == this.relation &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class ConceptRelationsCompanion extends UpdateCompanion<ConceptRelationRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> sourceId;
  final Value<String> targetId;
  final Value<String> relation;
  final Value<String?> description;
  final Value<int> createdAt;
  final Value<int> rowid;
  const ConceptRelationsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.targetId = const Value.absent(),
    this.relation = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConceptRelationsCompanion.insert({
    required String id,
    required String projectId,
    required String sourceId,
    required String targetId,
    required String relation,
    this.description = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       sourceId = Value(sourceId),
       targetId = Value(targetId),
       relation = Value(relation),
       createdAt = Value(createdAt);
  static Insertable<ConceptRelationRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? sourceId,
    Expression<String>? targetId,
    Expression<String>? relation,
    Expression<String>? description,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (sourceId != null) 'source_id': sourceId,
      if (targetId != null) 'target_id': targetId,
      if (relation != null) 'relation': relation,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConceptRelationsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? sourceId,
    Value<String>? targetId,
    Value<String>? relation,
    Value<String?>? description,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return ConceptRelationsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      sourceId: sourceId ?? this.sourceId,
      targetId: targetId ?? this.targetId,
      relation: relation ?? this.relation,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConceptRelationsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('relation: $relation, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CrossReferencesTable extends CrossReferences
    with TableInfo<$CrossReferencesTable, CrossReferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrossReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sourceDocIdMeta = const VerificationMeta(
    'sourceDocId',
  );
  @override
  late final GeneratedColumn<String> sourceDocId = GeneratedColumn<String>(
    'source_doc_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sourcePageMeta = const VerificationMeta(
    'sourcePage',
  );
  @override
  late final GeneratedColumn<int> sourcePage = GeneratedColumn<int>(
    'source_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTextMeta = const VerificationMeta(
    'sourceText',
  );
  @override
  late final GeneratedColumn<String> sourceText = GeneratedColumn<String>(
    'source_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDocIdMeta = const VerificationMeta(
    'targetDocId',
  );
  @override
  late final GeneratedColumn<String> targetDocId = GeneratedColumn<String>(
    'target_doc_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _targetPageMeta = const VerificationMeta(
    'targetPage',
  );
  @override
  late final GeneratedColumn<int> targetPage = GeneratedColumn<int>(
    'target_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTextMeta = const VerificationMeta(
    'targetText',
  );
  @override
  late final GeneratedColumn<String> targetText = GeneratedColumn<String>(
    'target_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationTypeMeta = const VerificationMeta(
    'relationType',
  );
  @override
  late final GeneratedColumn<String> relationType = GeneratedColumn<String>(
    'relation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceOriginMeta = const VerificationMeta(
    'sourceOrigin',
  );
  @override
  late final GeneratedColumn<String> sourceOrigin = GeneratedColumn<String>(
    'source_origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('user'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    sourceDocId,
    sourcePage,
    sourceText,
    targetDocId,
    targetPage,
    targetText,
    relationType,
    confidence,
    sourceOrigin,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cross_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<CrossReferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('source_doc_id')) {
      context.handle(
        _sourceDocIdMeta,
        sourceDocId.isAcceptableOrUnknown(
          data['source_doc_id']!,
          _sourceDocIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceDocIdMeta);
    }
    if (data.containsKey('source_page')) {
      context.handle(
        _sourcePageMeta,
        sourcePage.isAcceptableOrUnknown(data['source_page']!, _sourcePageMeta),
      );
    } else if (isInserting) {
      context.missing(_sourcePageMeta);
    }
    if (data.containsKey('source_text')) {
      context.handle(
        _sourceTextMeta,
        sourceText.isAcceptableOrUnknown(data['source_text']!, _sourceTextMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTextMeta);
    }
    if (data.containsKey('target_doc_id')) {
      context.handle(
        _targetDocIdMeta,
        targetDocId.isAcceptableOrUnknown(
          data['target_doc_id']!,
          _targetDocIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetDocIdMeta);
    }
    if (data.containsKey('target_page')) {
      context.handle(
        _targetPageMeta,
        targetPage.isAcceptableOrUnknown(data['target_page']!, _targetPageMeta),
      );
    } else if (isInserting) {
      context.missing(_targetPageMeta);
    }
    if (data.containsKey('target_text')) {
      context.handle(
        _targetTextMeta,
        targetText.isAcceptableOrUnknown(data['target_text']!, _targetTextMeta),
      );
    } else if (isInserting) {
      context.missing(_targetTextMeta);
    }
    if (data.containsKey('relation_type')) {
      context.handle(
        _relationTypeMeta,
        relationType.isAcceptableOrUnknown(
          data['relation_type']!,
          _relationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationTypeMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('source_origin')) {
      context.handle(
        _sourceOriginMeta,
        sourceOrigin.isAcceptableOrUnknown(
          data['source_origin']!,
          _sourceOriginMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrossReferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrossReferenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      sourceDocId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_doc_id'],
      )!,
      sourcePage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_page'],
      )!,
      sourceText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_text'],
      )!,
      targetDocId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_doc_id'],
      )!,
      targetPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_page'],
      )!,
      targetText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_text'],
      )!,
      relationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation_type'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
      sourceOrigin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_origin'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CrossReferencesTable createAlias(String alias) {
    return $CrossReferencesTable(attachedDatabase, alias);
  }
}

class CrossReferenceRow extends DataClass
    implements Insertable<CrossReferenceRow> {
  final String id;
  final String projectId;
  final String sourceDocId;
  final int sourcePage;
  final String sourceText;
  final String targetDocId;
  final int targetPage;
  final String targetText;

  /// 'corroborates' | 'contradicts' | 'extends' | 'cites' | 'exemplifies'
  final String relationType;

  /// 0.0–1.0, null when created manually.
  final double? confidence;

  /// 'user' | 'ai'
  final String sourceOrigin;
  final int createdAt;
  const CrossReferenceRow({
    required this.id,
    required this.projectId,
    required this.sourceDocId,
    required this.sourcePage,
    required this.sourceText,
    required this.targetDocId,
    required this.targetPage,
    required this.targetText,
    required this.relationType,
    this.confidence,
    required this.sourceOrigin,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['source_doc_id'] = Variable<String>(sourceDocId);
    map['source_page'] = Variable<int>(sourcePage);
    map['source_text'] = Variable<String>(sourceText);
    map['target_doc_id'] = Variable<String>(targetDocId);
    map['target_page'] = Variable<int>(targetPage);
    map['target_text'] = Variable<String>(targetText);
    map['relation_type'] = Variable<String>(relationType);
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    map['source_origin'] = Variable<String>(sourceOrigin);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CrossReferencesCompanion toCompanion(bool nullToAbsent) {
    return CrossReferencesCompanion(
      id: Value(id),
      projectId: Value(projectId),
      sourceDocId: Value(sourceDocId),
      sourcePage: Value(sourcePage),
      sourceText: Value(sourceText),
      targetDocId: Value(targetDocId),
      targetPage: Value(targetPage),
      targetText: Value(targetText),
      relationType: Value(relationType),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      sourceOrigin: Value(sourceOrigin),
      createdAt: Value(createdAt),
    );
  }

  factory CrossReferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrossReferenceRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      sourceDocId: serializer.fromJson<String>(json['sourceDocId']),
      sourcePage: serializer.fromJson<int>(json['sourcePage']),
      sourceText: serializer.fromJson<String>(json['sourceText']),
      targetDocId: serializer.fromJson<String>(json['targetDocId']),
      targetPage: serializer.fromJson<int>(json['targetPage']),
      targetText: serializer.fromJson<String>(json['targetText']),
      relationType: serializer.fromJson<String>(json['relationType']),
      confidence: serializer.fromJson<double?>(json['confidence']),
      sourceOrigin: serializer.fromJson<String>(json['sourceOrigin']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'sourceDocId': serializer.toJson<String>(sourceDocId),
      'sourcePage': serializer.toJson<int>(sourcePage),
      'sourceText': serializer.toJson<String>(sourceText),
      'targetDocId': serializer.toJson<String>(targetDocId),
      'targetPage': serializer.toJson<int>(targetPage),
      'targetText': serializer.toJson<String>(targetText),
      'relationType': serializer.toJson<String>(relationType),
      'confidence': serializer.toJson<double?>(confidence),
      'sourceOrigin': serializer.toJson<String>(sourceOrigin),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CrossReferenceRow copyWith({
    String? id,
    String? projectId,
    String? sourceDocId,
    int? sourcePage,
    String? sourceText,
    String? targetDocId,
    int? targetPage,
    String? targetText,
    String? relationType,
    Value<double?> confidence = const Value.absent(),
    String? sourceOrigin,
    int? createdAt,
  }) => CrossReferenceRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    sourceDocId: sourceDocId ?? this.sourceDocId,
    sourcePage: sourcePage ?? this.sourcePage,
    sourceText: sourceText ?? this.sourceText,
    targetDocId: targetDocId ?? this.targetDocId,
    targetPage: targetPage ?? this.targetPage,
    targetText: targetText ?? this.targetText,
    relationType: relationType ?? this.relationType,
    confidence: confidence.present ? confidence.value : this.confidence,
    sourceOrigin: sourceOrigin ?? this.sourceOrigin,
    createdAt: createdAt ?? this.createdAt,
  );
  CrossReferenceRow copyWithCompanion(CrossReferencesCompanion data) {
    return CrossReferenceRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      sourceDocId: data.sourceDocId.present
          ? data.sourceDocId.value
          : this.sourceDocId,
      sourcePage: data.sourcePage.present
          ? data.sourcePage.value
          : this.sourcePage,
      sourceText: data.sourceText.present
          ? data.sourceText.value
          : this.sourceText,
      targetDocId: data.targetDocId.present
          ? data.targetDocId.value
          : this.targetDocId,
      targetPage: data.targetPage.present
          ? data.targetPage.value
          : this.targetPage,
      targetText: data.targetText.present
          ? data.targetText.value
          : this.targetText,
      relationType: data.relationType.present
          ? data.relationType.value
          : this.relationType,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sourceOrigin: data.sourceOrigin.present
          ? data.sourceOrigin.value
          : this.sourceOrigin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrossReferenceRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sourceDocId: $sourceDocId, ')
          ..write('sourcePage: $sourcePage, ')
          ..write('sourceText: $sourceText, ')
          ..write('targetDocId: $targetDocId, ')
          ..write('targetPage: $targetPage, ')
          ..write('targetText: $targetText, ')
          ..write('relationType: $relationType, ')
          ..write('confidence: $confidence, ')
          ..write('sourceOrigin: $sourceOrigin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    sourceDocId,
    sourcePage,
    sourceText,
    targetDocId,
    targetPage,
    targetText,
    relationType,
    confidence,
    sourceOrigin,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrossReferenceRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.sourceDocId == this.sourceDocId &&
          other.sourcePage == this.sourcePage &&
          other.sourceText == this.sourceText &&
          other.targetDocId == this.targetDocId &&
          other.targetPage == this.targetPage &&
          other.targetText == this.targetText &&
          other.relationType == this.relationType &&
          other.confidence == this.confidence &&
          other.sourceOrigin == this.sourceOrigin &&
          other.createdAt == this.createdAt);
}

class CrossReferencesCompanion extends UpdateCompanion<CrossReferenceRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> sourceDocId;
  final Value<int> sourcePage;
  final Value<String> sourceText;
  final Value<String> targetDocId;
  final Value<int> targetPage;
  final Value<String> targetText;
  final Value<String> relationType;
  final Value<double?> confidence;
  final Value<String> sourceOrigin;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CrossReferencesCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.sourceDocId = const Value.absent(),
    this.sourcePage = const Value.absent(),
    this.sourceText = const Value.absent(),
    this.targetDocId = const Value.absent(),
    this.targetPage = const Value.absent(),
    this.targetText = const Value.absent(),
    this.relationType = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sourceOrigin = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CrossReferencesCompanion.insert({
    required String id,
    required String projectId,
    required String sourceDocId,
    required int sourcePage,
    required String sourceText,
    required String targetDocId,
    required int targetPage,
    required String targetText,
    required String relationType,
    this.confidence = const Value.absent(),
    this.sourceOrigin = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       sourceDocId = Value(sourceDocId),
       sourcePage = Value(sourcePage),
       sourceText = Value(sourceText),
       targetDocId = Value(targetDocId),
       targetPage = Value(targetPage),
       targetText = Value(targetText),
       relationType = Value(relationType),
       createdAt = Value(createdAt);
  static Insertable<CrossReferenceRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? sourceDocId,
    Expression<int>? sourcePage,
    Expression<String>? sourceText,
    Expression<String>? targetDocId,
    Expression<int>? targetPage,
    Expression<String>? targetText,
    Expression<String>? relationType,
    Expression<double>? confidence,
    Expression<String>? sourceOrigin,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (sourceDocId != null) 'source_doc_id': sourceDocId,
      if (sourcePage != null) 'source_page': sourcePage,
      if (sourceText != null) 'source_text': sourceText,
      if (targetDocId != null) 'target_doc_id': targetDocId,
      if (targetPage != null) 'target_page': targetPage,
      if (targetText != null) 'target_text': targetText,
      if (relationType != null) 'relation_type': relationType,
      if (confidence != null) 'confidence': confidence,
      if (sourceOrigin != null) 'source_origin': sourceOrigin,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CrossReferencesCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? sourceDocId,
    Value<int>? sourcePage,
    Value<String>? sourceText,
    Value<String>? targetDocId,
    Value<int>? targetPage,
    Value<String>? targetText,
    Value<String>? relationType,
    Value<double?>? confidence,
    Value<String>? sourceOrigin,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CrossReferencesCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      sourceDocId: sourceDocId ?? this.sourceDocId,
      sourcePage: sourcePage ?? this.sourcePage,
      sourceText: sourceText ?? this.sourceText,
      targetDocId: targetDocId ?? this.targetDocId,
      targetPage: targetPage ?? this.targetPage,
      targetText: targetText ?? this.targetText,
      relationType: relationType ?? this.relationType,
      confidence: confidence ?? this.confidence,
      sourceOrigin: sourceOrigin ?? this.sourceOrigin,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (sourceDocId.present) {
      map['source_doc_id'] = Variable<String>(sourceDocId.value);
    }
    if (sourcePage.present) {
      map['source_page'] = Variable<int>(sourcePage.value);
    }
    if (sourceText.present) {
      map['source_text'] = Variable<String>(sourceText.value);
    }
    if (targetDocId.present) {
      map['target_doc_id'] = Variable<String>(targetDocId.value);
    }
    if (targetPage.present) {
      map['target_page'] = Variable<int>(targetPage.value);
    }
    if (targetText.present) {
      map['target_text'] = Variable<String>(targetText.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(relationType.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sourceOrigin.present) {
      map['source_origin'] = Variable<String>(sourceOrigin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrossReferencesCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sourceDocId: $sourceDocId, ')
          ..write('sourcePage: $sourcePage, ')
          ..write('sourceText: $sourceText, ')
          ..write('targetDocId: $targetDocId, ')
          ..write('targetPage: $targetPage, ')
          ..write('targetText: $targetText, ')
          ..write('relationType: $relationType, ')
          ..write('confidence: $confidence, ')
          ..write('sourceOrigin: $sourceOrigin, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatSessionsTable extends ChatSessions
    with TableInfo<$ChatSessionsTable, ChatSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    documentId,
    title,
    provider,
    model,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ChatSessionsTable createAlias(String alias) {
    return $ChatSessionsTable(attachedDatabase, alias);
  }
}

class ChatSessionRow extends DataClass implements Insertable<ChatSessionRow> {
  final String id;
  final String projectId;

  /// Null = project-level session.
  final String? documentId;
  final String? title;
  final String provider;
  final String model;
  final int createdAt;
  const ChatSessionRow({
    required this.id,
    required this.projectId,
    this.documentId,
    this.title,
    required this.provider,
    required this.model,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<String>(documentId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['provider'] = Variable<String>(provider);
    map['model'] = Variable<String>(model);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ChatSessionsCompanion toCompanion(bool nullToAbsent) {
    return ChatSessionsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      provider: Value(provider),
      model: Value(model),
      createdAt: Value(createdAt),
    );
  }

  factory ChatSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatSessionRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      documentId: serializer.fromJson<String?>(json['documentId']),
      title: serializer.fromJson<String?>(json['title']),
      provider: serializer.fromJson<String>(json['provider']),
      model: serializer.fromJson<String>(json['model']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'documentId': serializer.toJson<String?>(documentId),
      'title': serializer.toJson<String?>(title),
      'provider': serializer.toJson<String>(provider),
      'model': serializer.toJson<String>(model),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ChatSessionRow copyWith({
    String? id,
    String? projectId,
    Value<String?> documentId = const Value.absent(),
    Value<String?> title = const Value.absent(),
    String? provider,
    String? model,
    int? createdAt,
  }) => ChatSessionRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    documentId: documentId.present ? documentId.value : this.documentId,
    title: title.present ? title.value : this.title,
    provider: provider ?? this.provider,
    model: model ?? this.model,
    createdAt: createdAt ?? this.createdAt,
  );
  ChatSessionRow copyWithCompanion(ChatSessionsCompanion data) {
    return ChatSessionRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      title: data.title.present ? data.title.value : this.title,
      provider: data.provider.present ? data.provider.value : this.provider,
      model: data.model.present ? data.model.value : this.model,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatSessionRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('documentId: $documentId, ')
          ..write('title: $title, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, documentId, title, provider, model, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatSessionRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.documentId == this.documentId &&
          other.title == this.title &&
          other.provider == this.provider &&
          other.model == this.model &&
          other.createdAt == this.createdAt);
}

class ChatSessionsCompanion extends UpdateCompanion<ChatSessionRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String?> documentId;
  final Value<String?> title;
  final Value<String> provider;
  final Value<String> model;
  final Value<int> createdAt;
  final Value<int> rowid;
  const ChatSessionsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.title = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatSessionsCompanion.insert({
    required String id,
    required String projectId,
    this.documentId = const Value.absent(),
    this.title = const Value.absent(),
    required String provider,
    required String model,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       provider = Value(provider),
       model = Value(model),
       createdAt = Value(createdAt);
  static Insertable<ChatSessionRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? documentId,
    Expression<String>? title,
    Expression<String>? provider,
    Expression<String>? model,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (documentId != null) 'document_id': documentId,
      if (title != null) 'title': title,
      if (provider != null) 'provider': provider,
      if (model != null) 'model': model,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String?>? documentId,
    Value<String?>? title,
    Value<String>? provider,
    Value<String>? model,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return ChatSessionsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      documentId: documentId ?? this.documentId,
      title: title ?? this.title,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatSessionsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('documentId: $documentId, ')
          ..write('title: $title, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chat_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextMeta = const VerificationMeta(
    'context',
  );
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
    'context',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompressedMeta = const VerificationMeta(
    'isCompressed',
  );
  @override
  late final GeneratedColumn<bool> isCompressed = GeneratedColumn<bool>(
    'is_compressed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_compressed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    role,
    content,
    context,
    isCompressed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('context')) {
      context.handle(
        _contextMeta,
        this.context.isAcceptableOrUnknown(data['context']!, _contextMeta),
      );
    }
    if (data.containsKey('is_compressed')) {
      context.handle(
        _isCompressedMeta,
        isCompressed.isAcceptableOrUnknown(
          data['is_compressed']!,
          _isCompressedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      context: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context'],
      ),
      isCompressed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_compressed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessageRow extends DataClass implements Insertable<ChatMessageRow> {
  final String id;
  final String sessionId;

  /// 'user' | 'assistant' | 'system'
  final String role;
  final String content;

  /// JSON: { selectedText, pageNumber, selectionLevel }
  final String? context;

  /// True when this row is a compressed summary of older turns.
  final bool isCompressed;
  final int createdAt;
  const ChatMessageRow({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    this.context,
    required this.isCompressed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || context != null) {
      map['context'] = Variable<String>(context);
    }
    map['is_compressed'] = Variable<bool>(isCompressed);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      role: Value(role),
      content: Value(content),
      context: context == null && nullToAbsent
          ? const Value.absent()
          : Value(context),
      isCompressed: Value(isCompressed),
      createdAt: Value(createdAt),
    );
  }

  factory ChatMessageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      context: serializer.fromJson<String?>(json['context']),
      isCompressed: serializer.fromJson<bool>(json['isCompressed']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'context': serializer.toJson<String?>(context),
      'isCompressed': serializer.toJson<bool>(isCompressed),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ChatMessageRow copyWith({
    String? id,
    String? sessionId,
    String? role,
    String? content,
    Value<String?> context = const Value.absent(),
    bool? isCompressed,
    int? createdAt,
  }) => ChatMessageRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    role: role ?? this.role,
    content: content ?? this.content,
    context: context.present ? context.value : this.context,
    isCompressed: isCompressed ?? this.isCompressed,
    createdAt: createdAt ?? this.createdAt,
  );
  ChatMessageRow copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessageRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      context: data.context.present ? data.context.value : this.context,
      isCompressed: data.isCompressed.present
          ? data.isCompressed.value
          : this.isCompressed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('context: $context, ')
          ..write('isCompressed: $isCompressed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    role,
    content,
    context,
    isCompressed,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessageRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.role == this.role &&
          other.content == this.content &&
          other.context == this.context &&
          other.isCompressed == this.isCompressed &&
          other.createdAt == this.createdAt);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessageRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> role;
  final Value<String> content;
  final Value<String?> context;
  final Value<bool> isCompressed;
  final Value<int> createdAt;
  final Value<int> rowid;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.context = const Value.absent(),
    this.isCompressed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    required String id,
    required String sessionId,
    required String role,
    required String content,
    this.context = const Value.absent(),
    this.isCompressed = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       role = Value(role),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<ChatMessageRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<String>? context,
    Expression<bool>? isCompressed,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (context != null) 'context': context,
      if (isCompressed != null) 'is_compressed': isCompressed,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? role,
    Value<String>? content,
    Value<String?>? context,
    Value<bool>? isCompressed,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      role: role ?? this.role,
      content: content ?? this.content,
      context: context ?? this.context,
      isCompressed: isCompressed ?? this.isCompressed,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (isCompressed.present) {
      map['is_compressed'] = Variable<bool>(isCompressed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('context: $context, ')
          ..write('isCompressed: $isCompressed, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiProvidersTable extends AiProviders
    with TableInfo<$AiProvidersTable, AiProviderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelsMeta = const VerificationMeta('models');
  @override
  late final GeneratedColumn<String> models = GeneratedColumn<String>(
    'models',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _settingsMeta = const VerificationMeta(
    'settings',
  );
  @override
  late final GeneratedColumn<String> settings = GeneratedColumn<String>(
    'settings',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    isActive,
    baseUrl,
    models,
    settings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProviderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    }
    if (data.containsKey('models')) {
      context.handle(
        _modelsMeta,
        models.isAcceptableOrUnknown(data['models']!, _modelsMeta),
      );
    }
    if (data.containsKey('settings')) {
      context.handle(
        _settingsMeta,
        settings.isAcceptableOrUnknown(data['settings']!, _settingsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiProviderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProviderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      ),
      models: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}models'],
      ),
      settings: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settings'],
      ),
    );
  }

  @override
  $AiProvidersTable createAlias(String alias) {
    return $AiProvidersTable(attachedDatabase, alias);
  }
}

class AiProviderRow extends DataClass implements Insertable<AiProviderRow> {
  /// 'openrouter' | 'openai' | 'anthropic' | 'google' | 'ollama'
  final String id;
  final String name;
  final bool isActive;

  /// For Ollama or custom proxies.
  final String? baseUrl;

  /// JSON array: available/preferred models.
  final String? models;

  /// JSON: { temperature, maxTokens, ... }
  final String? settings;
  const AiProviderRow({
    required this.id,
    required this.name,
    required this.isActive,
    this.baseUrl,
    this.models,
    this.settings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || baseUrl != null) {
      map['base_url'] = Variable<String>(baseUrl);
    }
    if (!nullToAbsent || models != null) {
      map['models'] = Variable<String>(models);
    }
    if (!nullToAbsent || settings != null) {
      map['settings'] = Variable<String>(settings);
    }
    return map;
  }

  AiProvidersCompanion toCompanion(bool nullToAbsent) {
    return AiProvidersCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
      baseUrl: baseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(baseUrl),
      models: models == null && nullToAbsent
          ? const Value.absent()
          : Value(models),
      settings: settings == null && nullToAbsent
          ? const Value.absent()
          : Value(settings),
    );
  }

  factory AiProviderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProviderRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      baseUrl: serializer.fromJson<String?>(json['baseUrl']),
      models: serializer.fromJson<String?>(json['models']),
      settings: serializer.fromJson<String?>(json['settings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'baseUrl': serializer.toJson<String?>(baseUrl),
      'models': serializer.toJson<String?>(models),
      'settings': serializer.toJson<String?>(settings),
    };
  }

  AiProviderRow copyWith({
    String? id,
    String? name,
    bool? isActive,
    Value<String?> baseUrl = const Value.absent(),
    Value<String?> models = const Value.absent(),
    Value<String?> settings = const Value.absent(),
  }) => AiProviderRow(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    baseUrl: baseUrl.present ? baseUrl.value : this.baseUrl,
    models: models.present ? models.value : this.models,
    settings: settings.present ? settings.value : this.settings,
  );
  AiProviderRow copyWithCompanion(AiProvidersCompanion data) {
    return AiProviderRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      models: data.models.present ? data.models.value : this.models,
      settings: data.settings.present ? data.settings.value : this.settings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('models: $models, ')
          ..write('settings: $settings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, isActive, baseUrl, models, settings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProviderRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.baseUrl == this.baseUrl &&
          other.models == this.models &&
          other.settings == this.settings);
}

class AiProvidersCompanion extends UpdateCompanion<AiProviderRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<String?> baseUrl;
  final Value<String?> models;
  final Value<String?> settings;
  final Value<int> rowid;
  const AiProvidersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.models = const Value.absent(),
    this.settings = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiProvidersCompanion.insert({
    required String id,
    required String name,
    this.isActive = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.models = const Value.absent(),
    this.settings = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<AiProviderRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<String>? baseUrl,
    Expression<String>? models,
    Expression<String>? settings,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (baseUrl != null) 'base_url': baseUrl,
      if (models != null) 'models': models,
      if (settings != null) 'settings': settings,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiProvidersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<bool>? isActive,
    Value<String?>? baseUrl,
    Value<String?>? models,
    Value<String?>? settings,
    Value<int>? rowid,
  }) {
    return AiProvidersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      baseUrl: baseUrl ?? this.baseUrl,
      models: models ?? this.models,
      settings: settings ?? this.settings,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (models.present) {
      map['models'] = Variable<String>(models.value);
    }
    if (settings.present) {
      map['settings'] = Variable<String>(settings.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProvidersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('models: $models, ')
          ..write('settings: $settings, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiResponseCacheTable extends AiResponseCache
    with TableInfo<$AiResponseCacheTable, AiResponseCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiResponseCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _inputHashMeta = const VerificationMeta(
    'inputHash',
  );
  @override
  late final GeneratedColumn<String> inputHash = GeneratedColumn<String>(
    'input_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aiModeMeta = const VerificationMeta('aiMode');
  @override
  late final GeneratedColumn<String> aiMode = GeneratedColumn<String>(
    'ai_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptVersionMeta = const VerificationMeta(
    'promptVersion',
  );
  @override
  late final GeneratedColumn<String> promptVersion = GeneratedColumn<String>(
    'prompt_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responseMeta = const VerificationMeta(
    'response',
  );
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
    'response',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inputTokensMeta = const VerificationMeta(
    'inputTokens',
  );
  @override
  late final GeneratedColumn<int> inputTokens = GeneratedColumn<int>(
    'input_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outputTokensMeta = const VerificationMeta(
    'outputTokens',
  );
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
    'output_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<int> lastUsedAt = GeneratedColumn<int>(
    'last_used_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _useCountMeta = const VerificationMeta(
    'useCount',
  );
  @override
  late final GeneratedColumn<int> useCount = GeneratedColumn<int>(
    'use_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cacheKey,
    inputHash,
    aiMode,
    promptVersion,
    provider,
    model,
    response,
    inputTokens,
    outputTokens,
    createdAt,
    lastUsedAt,
    useCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_response_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiResponseCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('input_hash')) {
      context.handle(
        _inputHashMeta,
        inputHash.isAcceptableOrUnknown(data['input_hash']!, _inputHashMeta),
      );
    } else if (isInserting) {
      context.missing(_inputHashMeta);
    }
    if (data.containsKey('ai_mode')) {
      context.handle(
        _aiModeMeta,
        aiMode.isAcceptableOrUnknown(data['ai_mode']!, _aiModeMeta),
      );
    } else if (isInserting) {
      context.missing(_aiModeMeta);
    }
    if (data.containsKey('prompt_version')) {
      context.handle(
        _promptVersionMeta,
        promptVersion.isAcceptableOrUnknown(
          data['prompt_version']!,
          _promptVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_promptVersionMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('response')) {
      context.handle(
        _responseMeta,
        response.isAcceptableOrUnknown(data['response']!, _responseMeta),
      );
    } else if (isInserting) {
      context.missing(_responseMeta);
    }
    if (data.containsKey('input_tokens')) {
      context.handle(
        _inputTokensMeta,
        inputTokens.isAcceptableOrUnknown(
          data['input_tokens']!,
          _inputTokensMeta,
        ),
      );
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
        _outputTokensMeta,
        outputTokens.isAcceptableOrUnknown(
          data['output_tokens']!,
          _outputTokensMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUsedAtMeta);
    }
    if (data.containsKey('use_count')) {
      context.handle(
        _useCountMeta,
        useCount.isAcceptableOrUnknown(data['use_count']!, _useCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiResponseCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiResponseCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      inputHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_hash'],
      )!,
      aiMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_mode'],
      )!,
      promptVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_version'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      response: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response'],
      )!,
      inputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_tokens'],
      ),
      outputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_tokens'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_used_at'],
      )!,
      useCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}use_count'],
      )!,
    );
  }

  @override
  $AiResponseCacheTable createAlias(String alias) {
    return $AiResponseCacheTable(attachedDatabase, alias);
  }
}

class AiResponseCacheRow extends DataClass
    implements Insertable<AiResponseCacheRow> {
  final String id;

  /// hash(mode + prompt_version + input_hash + model)
  final String cacheKey;
  final String inputHash;
  final String aiMode;
  final String promptVersion;
  final String provider;
  final String model;
  final String response;
  final int? inputTokens;
  final int? outputTokens;
  final int createdAt;
  final int lastUsedAt;
  final int useCount;
  const AiResponseCacheRow({
    required this.id,
    required this.cacheKey,
    required this.inputHash,
    required this.aiMode,
    required this.promptVersion,
    required this.provider,
    required this.model,
    required this.response,
    this.inputTokens,
    this.outputTokens,
    required this.createdAt,
    required this.lastUsedAt,
    required this.useCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['cache_key'] = Variable<String>(cacheKey);
    map['input_hash'] = Variable<String>(inputHash);
    map['ai_mode'] = Variable<String>(aiMode);
    map['prompt_version'] = Variable<String>(promptVersion);
    map['provider'] = Variable<String>(provider);
    map['model'] = Variable<String>(model);
    map['response'] = Variable<String>(response);
    if (!nullToAbsent || inputTokens != null) {
      map['input_tokens'] = Variable<int>(inputTokens);
    }
    if (!nullToAbsent || outputTokens != null) {
      map['output_tokens'] = Variable<int>(outputTokens);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['last_used_at'] = Variable<int>(lastUsedAt);
    map['use_count'] = Variable<int>(useCount);
    return map;
  }

  AiResponseCacheCompanion toCompanion(bool nullToAbsent) {
    return AiResponseCacheCompanion(
      id: Value(id),
      cacheKey: Value(cacheKey),
      inputHash: Value(inputHash),
      aiMode: Value(aiMode),
      promptVersion: Value(promptVersion),
      provider: Value(provider),
      model: Value(model),
      response: Value(response),
      inputTokens: inputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(inputTokens),
      outputTokens: outputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(outputTokens),
      createdAt: Value(createdAt),
      lastUsedAt: Value(lastUsedAt),
      useCount: Value(useCount),
    );
  }

  factory AiResponseCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiResponseCacheRow(
      id: serializer.fromJson<String>(json['id']),
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      inputHash: serializer.fromJson<String>(json['inputHash']),
      aiMode: serializer.fromJson<String>(json['aiMode']),
      promptVersion: serializer.fromJson<String>(json['promptVersion']),
      provider: serializer.fromJson<String>(json['provider']),
      model: serializer.fromJson<String>(json['model']),
      response: serializer.fromJson<String>(json['response']),
      inputTokens: serializer.fromJson<int?>(json['inputTokens']),
      outputTokens: serializer.fromJson<int?>(json['outputTokens']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      lastUsedAt: serializer.fromJson<int>(json['lastUsedAt']),
      useCount: serializer.fromJson<int>(json['useCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cacheKey': serializer.toJson<String>(cacheKey),
      'inputHash': serializer.toJson<String>(inputHash),
      'aiMode': serializer.toJson<String>(aiMode),
      'promptVersion': serializer.toJson<String>(promptVersion),
      'provider': serializer.toJson<String>(provider),
      'model': serializer.toJson<String>(model),
      'response': serializer.toJson<String>(response),
      'inputTokens': serializer.toJson<int?>(inputTokens),
      'outputTokens': serializer.toJson<int?>(outputTokens),
      'createdAt': serializer.toJson<int>(createdAt),
      'lastUsedAt': serializer.toJson<int>(lastUsedAt),
      'useCount': serializer.toJson<int>(useCount),
    };
  }

  AiResponseCacheRow copyWith({
    String? id,
    String? cacheKey,
    String? inputHash,
    String? aiMode,
    String? promptVersion,
    String? provider,
    String? model,
    String? response,
    Value<int?> inputTokens = const Value.absent(),
    Value<int?> outputTokens = const Value.absent(),
    int? createdAt,
    int? lastUsedAt,
    int? useCount,
  }) => AiResponseCacheRow(
    id: id ?? this.id,
    cacheKey: cacheKey ?? this.cacheKey,
    inputHash: inputHash ?? this.inputHash,
    aiMode: aiMode ?? this.aiMode,
    promptVersion: promptVersion ?? this.promptVersion,
    provider: provider ?? this.provider,
    model: model ?? this.model,
    response: response ?? this.response,
    inputTokens: inputTokens.present ? inputTokens.value : this.inputTokens,
    outputTokens: outputTokens.present ? outputTokens.value : this.outputTokens,
    createdAt: createdAt ?? this.createdAt,
    lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    useCount: useCount ?? this.useCount,
  );
  AiResponseCacheRow copyWithCompanion(AiResponseCacheCompanion data) {
    return AiResponseCacheRow(
      id: data.id.present ? data.id.value : this.id,
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      inputHash: data.inputHash.present ? data.inputHash.value : this.inputHash,
      aiMode: data.aiMode.present ? data.aiMode.value : this.aiMode,
      promptVersion: data.promptVersion.present
          ? data.promptVersion.value
          : this.promptVersion,
      provider: data.provider.present ? data.provider.value : this.provider,
      model: data.model.present ? data.model.value : this.model,
      response: data.response.present ? data.response.value : this.response,
      inputTokens: data.inputTokens.present
          ? data.inputTokens.value
          : this.inputTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
      useCount: data.useCount.present ? data.useCount.value : this.useCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiResponseCacheRow(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('inputHash: $inputHash, ')
          ..write('aiMode: $aiMode, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('response: $response, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('useCount: $useCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cacheKey,
    inputHash,
    aiMode,
    promptVersion,
    provider,
    model,
    response,
    inputTokens,
    outputTokens,
    createdAt,
    lastUsedAt,
    useCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiResponseCacheRow &&
          other.id == this.id &&
          other.cacheKey == this.cacheKey &&
          other.inputHash == this.inputHash &&
          other.aiMode == this.aiMode &&
          other.promptVersion == this.promptVersion &&
          other.provider == this.provider &&
          other.model == this.model &&
          other.response == this.response &&
          other.inputTokens == this.inputTokens &&
          other.outputTokens == this.outputTokens &&
          other.createdAt == this.createdAt &&
          other.lastUsedAt == this.lastUsedAt &&
          other.useCount == this.useCount);
}

class AiResponseCacheCompanion extends UpdateCompanion<AiResponseCacheRow> {
  final Value<String> id;
  final Value<String> cacheKey;
  final Value<String> inputHash;
  final Value<String> aiMode;
  final Value<String> promptVersion;
  final Value<String> provider;
  final Value<String> model;
  final Value<String> response;
  final Value<int?> inputTokens;
  final Value<int?> outputTokens;
  final Value<int> createdAt;
  final Value<int> lastUsedAt;
  final Value<int> useCount;
  final Value<int> rowid;
  const AiResponseCacheCompanion({
    this.id = const Value.absent(),
    this.cacheKey = const Value.absent(),
    this.inputHash = const Value.absent(),
    this.aiMode = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.response = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.useCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiResponseCacheCompanion.insert({
    required String id,
    required String cacheKey,
    required String inputHash,
    required String aiMode,
    required String promptVersion,
    required String provider,
    required String model,
    required String response,
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    required int createdAt,
    required int lastUsedAt,
    this.useCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cacheKey = Value(cacheKey),
       inputHash = Value(inputHash),
       aiMode = Value(aiMode),
       promptVersion = Value(promptVersion),
       provider = Value(provider),
       model = Value(model),
       response = Value(response),
       createdAt = Value(createdAt),
       lastUsedAt = Value(lastUsedAt);
  static Insertable<AiResponseCacheRow> custom({
    Expression<String>? id,
    Expression<String>? cacheKey,
    Expression<String>? inputHash,
    Expression<String>? aiMode,
    Expression<String>? promptVersion,
    Expression<String>? provider,
    Expression<String>? model,
    Expression<String>? response,
    Expression<int>? inputTokens,
    Expression<int>? outputTokens,
    Expression<int>? createdAt,
    Expression<int>? lastUsedAt,
    Expression<int>? useCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cacheKey != null) 'cache_key': cacheKey,
      if (inputHash != null) 'input_hash': inputHash,
      if (aiMode != null) 'ai_mode': aiMode,
      if (promptVersion != null) 'prompt_version': promptVersion,
      if (provider != null) 'provider': provider,
      if (model != null) 'model': model,
      if (response != null) 'response': response,
      if (inputTokens != null) 'input_tokens': inputTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (useCount != null) 'use_count': useCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiResponseCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? cacheKey,
    Value<String>? inputHash,
    Value<String>? aiMode,
    Value<String>? promptVersion,
    Value<String>? provider,
    Value<String>? model,
    Value<String>? response,
    Value<int?>? inputTokens,
    Value<int?>? outputTokens,
    Value<int>? createdAt,
    Value<int>? lastUsedAt,
    Value<int>? useCount,
    Value<int>? rowid,
  }) {
    return AiResponseCacheCompanion(
      id: id ?? this.id,
      cacheKey: cacheKey ?? this.cacheKey,
      inputHash: inputHash ?? this.inputHash,
      aiMode: aiMode ?? this.aiMode,
      promptVersion: promptVersion ?? this.promptVersion,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      response: response ?? this.response,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      useCount: useCount ?? this.useCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (inputHash.present) {
      map['input_hash'] = Variable<String>(inputHash.value);
    }
    if (aiMode.present) {
      map['ai_mode'] = Variable<String>(aiMode.value);
    }
    if (promptVersion.present) {
      map['prompt_version'] = Variable<String>(promptVersion.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (inputTokens.present) {
      map['input_tokens'] = Variable<int>(inputTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<int>(lastUsedAt.value);
    }
    if (useCount.present) {
      map['use_count'] = Variable<int>(useCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiResponseCacheCompanion(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('inputHash: $inputHash, ')
          ..write('aiMode: $aiMode, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('response: $response, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('useCount: $useCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ApiUsageLogTable extends ApiUsageLog
    with TableInfo<$ApiUsageLogTable, ApiUsageLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiUsageLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _featureMeta = const VerificationMeta(
    'feature',
  );
  @override
  late final GeneratedColumn<String> feature = GeneratedColumn<String>(
    'feature',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inputTokensMeta = const VerificationMeta(
    'inputTokens',
  );
  @override
  late final GeneratedColumn<int> inputTokens = GeneratedColumn<int>(
    'input_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outputTokensMeta = const VerificationMeta(
    'outputTokens',
  );
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
    'output_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cacheHitMeta = const VerificationMeta(
    'cacheHit',
  );
  @override
  late final GeneratedColumn<bool> cacheHit = GeneratedColumn<bool>(
    'cache_hit',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cache_hit" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _costUsdMeta = const VerificationMeta(
    'costUsd',
  );
  @override
  late final GeneratedColumn<double> costUsd = GeneratedColumn<double>(
    'cost_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calledAtMeta = const VerificationMeta(
    'calledAt',
  );
  @override
  late final GeneratedColumn<int> calledAt = GeneratedColumn<int>(
    'called_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    documentId,
    provider,
    model,
    feature,
    inputTokens,
    outputTokens,
    cacheHit,
    costUsd,
    calledAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'api_usage_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApiUsageLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('feature')) {
      context.handle(
        _featureMeta,
        feature.isAcceptableOrUnknown(data['feature']!, _featureMeta),
      );
    } else if (isInserting) {
      context.missing(_featureMeta);
    }
    if (data.containsKey('input_tokens')) {
      context.handle(
        _inputTokensMeta,
        inputTokens.isAcceptableOrUnknown(
          data['input_tokens']!,
          _inputTokensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inputTokensMeta);
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
        _outputTokensMeta,
        outputTokens.isAcceptableOrUnknown(
          data['output_tokens']!,
          _outputTokensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_outputTokensMeta);
    }
    if (data.containsKey('cache_hit')) {
      context.handle(
        _cacheHitMeta,
        cacheHit.isAcceptableOrUnknown(data['cache_hit']!, _cacheHitMeta),
      );
    }
    if (data.containsKey('cost_usd')) {
      context.handle(
        _costUsdMeta,
        costUsd.isAcceptableOrUnknown(data['cost_usd']!, _costUsdMeta),
      );
    }
    if (data.containsKey('called_at')) {
      context.handle(
        _calledAtMeta,
        calledAt.isAcceptableOrUnknown(data['called_at']!, _calledAtMeta),
      );
    } else if (isInserting) {
      context.missing(_calledAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApiUsageLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApiUsageLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      ),
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      ),
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      feature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature'],
      )!,
      inputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_tokens'],
      )!,
      outputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_tokens'],
      )!,
      cacheHit: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cache_hit'],
      )!,
      costUsd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_usd'],
      ),
      calledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}called_at'],
      )!,
    );
  }

  @override
  $ApiUsageLogTable createAlias(String alias) {
    return $ApiUsageLogTable(attachedDatabase, alias);
  }
}

class ApiUsageLogRow extends DataClass implements Insertable<ApiUsageLogRow> {
  final String id;
  final String? projectId;
  final String? documentId;
  final String provider;
  final String model;

  /// 'summarize' | 'explain' | 'chat' | ...
  final String feature;
  final int inputTokens;
  final int outputTokens;
  final bool cacheHit;
  final double? costUsd;
  final int calledAt;
  const ApiUsageLogRow({
    required this.id,
    this.projectId,
    this.documentId,
    required this.provider,
    required this.model,
    required this.feature,
    required this.inputTokens,
    required this.outputTokens,
    required this.cacheHit,
    this.costUsd,
    required this.calledAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<String>(documentId);
    }
    map['provider'] = Variable<String>(provider);
    map['model'] = Variable<String>(model);
    map['feature'] = Variable<String>(feature);
    map['input_tokens'] = Variable<int>(inputTokens);
    map['output_tokens'] = Variable<int>(outputTokens);
    map['cache_hit'] = Variable<bool>(cacheHit);
    if (!nullToAbsent || costUsd != null) {
      map['cost_usd'] = Variable<double>(costUsd);
    }
    map['called_at'] = Variable<int>(calledAt);
    return map;
  }

  ApiUsageLogCompanion toCompanion(bool nullToAbsent) {
    return ApiUsageLogCompanion(
      id: Value(id),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      provider: Value(provider),
      model: Value(model),
      feature: Value(feature),
      inputTokens: Value(inputTokens),
      outputTokens: Value(outputTokens),
      cacheHit: Value(cacheHit),
      costUsd: costUsd == null && nullToAbsent
          ? const Value.absent()
          : Value(costUsd),
      calledAt: Value(calledAt),
    );
  }

  factory ApiUsageLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApiUsageLogRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      documentId: serializer.fromJson<String?>(json['documentId']),
      provider: serializer.fromJson<String>(json['provider']),
      model: serializer.fromJson<String>(json['model']),
      feature: serializer.fromJson<String>(json['feature']),
      inputTokens: serializer.fromJson<int>(json['inputTokens']),
      outputTokens: serializer.fromJson<int>(json['outputTokens']),
      cacheHit: serializer.fromJson<bool>(json['cacheHit']),
      costUsd: serializer.fromJson<double?>(json['costUsd']),
      calledAt: serializer.fromJson<int>(json['calledAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String?>(projectId),
      'documentId': serializer.toJson<String?>(documentId),
      'provider': serializer.toJson<String>(provider),
      'model': serializer.toJson<String>(model),
      'feature': serializer.toJson<String>(feature),
      'inputTokens': serializer.toJson<int>(inputTokens),
      'outputTokens': serializer.toJson<int>(outputTokens),
      'cacheHit': serializer.toJson<bool>(cacheHit),
      'costUsd': serializer.toJson<double?>(costUsd),
      'calledAt': serializer.toJson<int>(calledAt),
    };
  }

  ApiUsageLogRow copyWith({
    String? id,
    Value<String?> projectId = const Value.absent(),
    Value<String?> documentId = const Value.absent(),
    String? provider,
    String? model,
    String? feature,
    int? inputTokens,
    int? outputTokens,
    bool? cacheHit,
    Value<double?> costUsd = const Value.absent(),
    int? calledAt,
  }) => ApiUsageLogRow(
    id: id ?? this.id,
    projectId: projectId.present ? projectId.value : this.projectId,
    documentId: documentId.present ? documentId.value : this.documentId,
    provider: provider ?? this.provider,
    model: model ?? this.model,
    feature: feature ?? this.feature,
    inputTokens: inputTokens ?? this.inputTokens,
    outputTokens: outputTokens ?? this.outputTokens,
    cacheHit: cacheHit ?? this.cacheHit,
    costUsd: costUsd.present ? costUsd.value : this.costUsd,
    calledAt: calledAt ?? this.calledAt,
  );
  ApiUsageLogRow copyWithCompanion(ApiUsageLogCompanion data) {
    return ApiUsageLogRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      provider: data.provider.present ? data.provider.value : this.provider,
      model: data.model.present ? data.model.value : this.model,
      feature: data.feature.present ? data.feature.value : this.feature,
      inputTokens: data.inputTokens.present
          ? data.inputTokens.value
          : this.inputTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      cacheHit: data.cacheHit.present ? data.cacheHit.value : this.cacheHit,
      costUsd: data.costUsd.present ? data.costUsd.value : this.costUsd,
      calledAt: data.calledAt.present ? data.calledAt.value : this.calledAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApiUsageLogRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('documentId: $documentId, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('feature: $feature, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('cacheHit: $cacheHit, ')
          ..write('costUsd: $costUsd, ')
          ..write('calledAt: $calledAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    documentId,
    provider,
    model,
    feature,
    inputTokens,
    outputTokens,
    cacheHit,
    costUsd,
    calledAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiUsageLogRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.documentId == this.documentId &&
          other.provider == this.provider &&
          other.model == this.model &&
          other.feature == this.feature &&
          other.inputTokens == this.inputTokens &&
          other.outputTokens == this.outputTokens &&
          other.cacheHit == this.cacheHit &&
          other.costUsd == this.costUsd &&
          other.calledAt == this.calledAt);
}

class ApiUsageLogCompanion extends UpdateCompanion<ApiUsageLogRow> {
  final Value<String> id;
  final Value<String?> projectId;
  final Value<String?> documentId;
  final Value<String> provider;
  final Value<String> model;
  final Value<String> feature;
  final Value<int> inputTokens;
  final Value<int> outputTokens;
  final Value<bool> cacheHit;
  final Value<double?> costUsd;
  final Value<int> calledAt;
  final Value<int> rowid;
  const ApiUsageLogCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.feature = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.cacheHit = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.calledAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApiUsageLogCompanion.insert({
    required String id,
    this.projectId = const Value.absent(),
    this.documentId = const Value.absent(),
    required String provider,
    required String model,
    required String feature,
    required int inputTokens,
    required int outputTokens,
    this.cacheHit = const Value.absent(),
    this.costUsd = const Value.absent(),
    required int calledAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       provider = Value(provider),
       model = Value(model),
       feature = Value(feature),
       inputTokens = Value(inputTokens),
       outputTokens = Value(outputTokens),
       calledAt = Value(calledAt);
  static Insertable<ApiUsageLogRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? documentId,
    Expression<String>? provider,
    Expression<String>? model,
    Expression<String>? feature,
    Expression<int>? inputTokens,
    Expression<int>? outputTokens,
    Expression<bool>? cacheHit,
    Expression<double>? costUsd,
    Expression<int>? calledAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (documentId != null) 'document_id': documentId,
      if (provider != null) 'provider': provider,
      if (model != null) 'model': model,
      if (feature != null) 'feature': feature,
      if (inputTokens != null) 'input_tokens': inputTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (cacheHit != null) 'cache_hit': cacheHit,
      if (costUsd != null) 'cost_usd': costUsd,
      if (calledAt != null) 'called_at': calledAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApiUsageLogCompanion copyWith({
    Value<String>? id,
    Value<String?>? projectId,
    Value<String?>? documentId,
    Value<String>? provider,
    Value<String>? model,
    Value<String>? feature,
    Value<int>? inputTokens,
    Value<int>? outputTokens,
    Value<bool>? cacheHit,
    Value<double?>? costUsd,
    Value<int>? calledAt,
    Value<int>? rowid,
  }) {
    return ApiUsageLogCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      documentId: documentId ?? this.documentId,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      feature: feature ?? this.feature,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      cacheHit: cacheHit ?? this.cacheHit,
      costUsd: costUsd ?? this.costUsd,
      calledAt: calledAt ?? this.calledAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (feature.present) {
      map['feature'] = Variable<String>(feature.value);
    }
    if (inputTokens.present) {
      map['input_tokens'] = Variable<int>(inputTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (cacheHit.present) {
      map['cache_hit'] = Variable<bool>(cacheHit.value);
    }
    if (costUsd.present) {
      map['cost_usd'] = Variable<double>(costUsd.value);
    }
    if (calledAt.present) {
      map['called_at'] = Variable<int>(calledAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiUsageLogCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('documentId: $documentId, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('feature: $feature, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('cacheHit: $cacheHit, ')
          ..write('costUsd: $costUsd, ')
          ..write('calledAt: $calledAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingSessionsTable extends ReadingSessions
    with TableInfo<$ReadingSessionsTable, ReadingSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startPageMeta = const VerificationMeta(
    'startPage',
  );
  @override
  late final GeneratedColumn<int> startPage = GeneratedColumn<int>(
    'start_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endPageMeta = const VerificationMeta(
    'endPage',
  );
  @override
  late final GeneratedColumn<int> endPage = GeneratedColumn<int>(
    'end_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSMeta = const VerificationMeta(
    'durationS',
  );
  @override
  late final GeneratedColumn<int> durationS = GeneratedColumn<int>(
    'duration_s',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<int> endedAt = GeneratedColumn<int>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    startPage,
    endPage,
    durationS,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('start_page')) {
      context.handle(
        _startPageMeta,
        startPage.isAcceptableOrUnknown(data['start_page']!, _startPageMeta),
      );
    } else if (isInserting) {
      context.missing(_startPageMeta);
    }
    if (data.containsKey('end_page')) {
      context.handle(
        _endPageMeta,
        endPage.isAcceptableOrUnknown(data['end_page']!, _endPageMeta),
      );
    } else if (isInserting) {
      context.missing(_endPageMeta);
    }
    if (data.containsKey('duration_s')) {
      context.handle(
        _durationSMeta,
        durationS.isAcceptableOrUnknown(data['duration_s']!, _durationSMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      startPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_page'],
      )!,
      endPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_page'],
      )!,
      durationS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_s'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $ReadingSessionsTable createAlias(String alias) {
    return $ReadingSessionsTable(attachedDatabase, alias);
  }
}

class ReadingSessionRow extends DataClass
    implements Insertable<ReadingSessionRow> {
  final String id;
  final String documentId;
  final int startPage;
  final int endPage;
  final int? durationS;
  final int startedAt;
  final int? endedAt;
  const ReadingSessionRow({
    required this.id,
    required this.documentId,
    required this.startPage,
    required this.endPage,
    this.durationS,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['start_page'] = Variable<int>(startPage);
    map['end_page'] = Variable<int>(endPage);
    if (!nullToAbsent || durationS != null) {
      map['duration_s'] = Variable<int>(durationS);
    }
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<int>(endedAt);
    }
    return map;
  }

  ReadingSessionsCompanion toCompanion(bool nullToAbsent) {
    return ReadingSessionsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      startPage: Value(startPage),
      endPage: Value(endPage),
      durationS: durationS == null && nullToAbsent
          ? const Value.absent()
          : Value(durationS),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory ReadingSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingSessionRow(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      startPage: serializer.fromJson<int>(json['startPage']),
      endPage: serializer.fromJson<int>(json['endPage']),
      durationS: serializer.fromJson<int?>(json['durationS']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      endedAt: serializer.fromJson<int?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'startPage': serializer.toJson<int>(startPage),
      'endPage': serializer.toJson<int>(endPage),
      'durationS': serializer.toJson<int?>(durationS),
      'startedAt': serializer.toJson<int>(startedAt),
      'endedAt': serializer.toJson<int?>(endedAt),
    };
  }

  ReadingSessionRow copyWith({
    String? id,
    String? documentId,
    int? startPage,
    int? endPage,
    Value<int?> durationS = const Value.absent(),
    int? startedAt,
    Value<int?> endedAt = const Value.absent(),
  }) => ReadingSessionRow(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    startPage: startPage ?? this.startPage,
    endPage: endPage ?? this.endPage,
    durationS: durationS.present ? durationS.value : this.durationS,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  ReadingSessionRow copyWithCompanion(ReadingSessionsCompanion data) {
    return ReadingSessionRow(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      startPage: data.startPage.present ? data.startPage.value : this.startPage,
      endPage: data.endPage.present ? data.endPage.value : this.endPage,
      durationS: data.durationS.present ? data.durationS.value : this.durationS,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingSessionRow(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('startPage: $startPage, ')
          ..write('endPage: $endPage, ')
          ..write('durationS: $durationS, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    startPage,
    endPage,
    durationS,
    startedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingSessionRow &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.startPage == this.startPage &&
          other.endPage == this.endPage &&
          other.durationS == this.durationS &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class ReadingSessionsCompanion extends UpdateCompanion<ReadingSessionRow> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> startPage;
  final Value<int> endPage;
  final Value<int?> durationS;
  final Value<int> startedAt;
  final Value<int?> endedAt;
  final Value<int> rowid;
  const ReadingSessionsCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.startPage = const Value.absent(),
    this.endPage = const Value.absent(),
    this.durationS = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingSessionsCompanion.insert({
    required String id,
    required String documentId,
    required int startPage,
    required int endPage,
    this.durationS = const Value.absent(),
    required int startedAt,
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       startPage = Value(startPage),
       endPage = Value(endPage),
       startedAt = Value(startedAt);
  static Insertable<ReadingSessionRow> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? startPage,
    Expression<int>? endPage,
    Expression<int>? durationS,
    Expression<int>? startedAt,
    Expression<int>? endedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (startPage != null) 'start_page': startPage,
      if (endPage != null) 'end_page': endPage,
      if (durationS != null) 'duration_s': durationS,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? startPage,
    Value<int>? endPage,
    Value<int?>? durationS,
    Value<int>? startedAt,
    Value<int?>? endedAt,
    Value<int>? rowid,
  }) {
    return ReadingSessionsCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      durationS: durationS ?? this.durationS,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (startPage.present) {
      map['start_page'] = Variable<int>(startPage.value);
    }
    if (endPage.present) {
      map['end_page'] = Variable<int>(endPage.value);
    }
    if (durationS.present) {
      map['duration_s'] = Variable<int>(durationS.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<int>(endedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('startPage: $startPage, ')
          ..write('endPage: $endPage, ')
          ..write('durationS: $durationS, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LogoiDatabase extends GeneratedDatabase {
  _$LogoiDatabase(QueryExecutor e) : super(e);
  $LogoiDatabaseManager get managers => $LogoiDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $PageContentsTable pageContents = $PageContentsTable(this);
  late final $ParagraphsTable paragraphs = $ParagraphsTable(this);
  late final $ParagraphEmbeddingsTable paragraphEmbeddings =
      $ParagraphEmbeddingsTable(this);
  late final $DocumentStructureTable documentStructure =
      $DocumentStructureTable(this);
  late final $SectionSummariesTable sectionSummaries = $SectionSummariesTable(
    this,
  );
  late final $AnnotationsTable annotations = $AnnotationsTable(this);
  late final $AnnotationVersionsTable annotationVersions =
      $AnnotationVersionsTable(this);
  late final $NotebooksTable notebooks = $NotebooksTable(this);
  late final $ConceptsTable concepts = $ConceptsTable(this);
  late final $ConceptRelationsTable conceptRelations = $ConceptRelationsTable(
    this,
  );
  late final $CrossReferencesTable crossReferences = $CrossReferencesTable(
    this,
  );
  late final $ChatSessionsTable chatSessions = $ChatSessionsTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $AiProvidersTable aiProviders = $AiProvidersTable(this);
  late final $AiResponseCacheTable aiResponseCache = $AiResponseCacheTable(
    this,
  );
  late final $ApiUsageLogTable apiUsageLog = $ApiUsageLogTable(this);
  late final $ReadingSessionsTable readingSessions = $ReadingSessionsTable(
    this,
  );
  late final ProjectDao projectDao = ProjectDao(this as LogoiDatabase);
  late final DocumentDao documentDao = DocumentDao(this as LogoiDatabase);
  late final AnnotationDao annotationDao = AnnotationDao(this as LogoiDatabase);
  late final ChatDao chatDao = ChatDao(this as LogoiDatabase);
  late final ConceptDao conceptDao = ConceptDao(this as LogoiDatabase);
  late final AiDao aiDao = AiDao(this as LogoiDatabase);
  late final SearchDao searchDao = SearchDao(this as LogoiDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    documents,
    pageContents,
    paragraphs,
    paragraphEmbeddings,
    documentStructure,
    sectionSummaries,
    annotations,
    annotationVersions,
    notebooks,
    concepts,
    conceptRelations,
    crossReferences,
    chatSessions,
    chatMessages,
    aiProviders,
    aiResponseCache,
    apiUsageLog,
    readingSessions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('documents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('page_contents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('paragraphs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'paragraphs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('paragraph_embeddings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document_structure', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'document_structure',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document_structure', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'document_structure',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('section_summaries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('annotations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'annotations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('annotation_versions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notebooks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notebooks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('concepts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('concept_relations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'concepts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('concept_relations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'concepts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('concept_relations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cross_references', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cross_references', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cross_references', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chat_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chat_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chat_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chat_messages', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('api_usage_log', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('api_usage_log', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reading_sessions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<String?> area,
      Value<String> language,
      required int createdAt,
      required int updatedAt,
      Value<String?> settings,
      Value<int> rowid,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> area,
      Value<String> language,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<String?> settings,
      Value<int> rowid,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$LogoiDatabase, $ProjectsTable, ProjectRow> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DocumentsTable, List<DocumentRow>>
  _documentsRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'projects__id__documents__project_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotebooksTable, List<NotebookRow>>
  _notebooksRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.notebooks,
    aliasName: 'projects__id__notebooks__project_id',
  );

  $$NotebooksTableProcessedTableManager get notebooksRefs {
    final manager = $$NotebooksTableTableManager(
      $_db,
      $_db.notebooks,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_notebooksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ConceptsTable, List<ConceptRow>>
  _conceptsRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.concepts,
    aliasName: 'projects__id__concepts__project_id',
  );

  $$ConceptsTableProcessedTableManager get conceptsRefs {
    final manager = $$ConceptsTableTableManager(
      $_db,
      $_db.concepts,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_conceptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ConceptRelationsTable, List<ConceptRelationRow>>
  _conceptRelationsRefsTable(_$LogoiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.conceptRelations,
        aliasName: 'projects__id__concept_relations__project_id',
      );

  $$ConceptRelationsTableProcessedTableManager get conceptRelationsRefs {
    final manager = $$ConceptRelationsTableTableManager(
      $_db,
      $_db.conceptRelations,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _conceptRelationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CrossReferencesTable, List<CrossReferenceRow>>
  _crossReferencesRefsTable(_$LogoiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.crossReferences,
        aliasName: 'projects__id__cross_references__project_id',
      );

  $$CrossReferencesTableProcessedTableManager get crossReferencesRefs {
    final manager = $$CrossReferencesTableTableManager(
      $_db,
      $_db.crossReferences,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _crossReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatSessionsTable, List<ChatSessionRow>>
  _chatSessionsRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.chatSessions,
    aliasName: 'projects__id__chat_sessions__project_id',
  );

  $$ChatSessionsTableProcessedTableManager get chatSessionsRefs {
    final manager = $$ChatSessionsTableTableManager(
      $_db,
      $_db.chatSessions,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ApiUsageLogTable, List<ApiUsageLogRow>>
  _apiUsageLogRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.apiUsageLog,
    aliasName: 'projects__id__api_usage_log__project_id',
  );

  $$ApiUsageLogTableProcessedTableManager get apiUsageLogRefs {
    final manager = $$ApiUsageLogTableTableManager(
      $_db,
      $_db.apiUsageLog,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_apiUsageLogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$LogoiDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settings => $composableBuilder(
    column: $table.settings,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notebooksRefs(
    Expression<bool> Function($$NotebooksTableFilterComposer f) f,
  ) {
    final $$NotebooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableFilterComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> conceptsRefs(
    Expression<bool> Function($$ConceptsTableFilterComposer f) f,
  ) {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> conceptRelationsRefs(
    Expression<bool> Function($$ConceptRelationsTableFilterComposer f) f,
  ) {
    final $$ConceptRelationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.conceptRelations,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptRelationsTableFilterComposer(
            $db: $db,
            $table: $db.conceptRelations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> crossReferencesRefs(
    Expression<bool> Function($$CrossReferencesTableFilterComposer f) f,
  ) {
    final $$CrossReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossReferences,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossReferencesTableFilterComposer(
            $db: $db,
            $table: $db.crossReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> chatSessionsRefs(
    Expression<bool> Function($$ChatSessionsTableFilterComposer f) f,
  ) {
    final $$ChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> apiUsageLogRefs(
    Expression<bool> Function($$ApiUsageLogTableFilterComposer f) f,
  ) {
    final $$ApiUsageLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.apiUsageLog,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiUsageLogTableFilterComposer(
            $db: $db,
            $table: $db.apiUsageLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settings => $composableBuilder(
    column: $table.settings,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get settings =>
      $composableBuilder(column: $table.settings, builder: (column) => column);

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notebooksRefs<T extends Object>(
    Expression<T> Function($$NotebooksTableAnnotationComposer a) f,
  ) {
    final $$NotebooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableAnnotationComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> conceptsRefs<T extends Object>(
    Expression<T> Function($$ConceptsTableAnnotationComposer a) f,
  ) {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> conceptRelationsRefs<T extends Object>(
    Expression<T> Function($$ConceptRelationsTableAnnotationComposer a) f,
  ) {
    final $$ConceptRelationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.conceptRelations,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptRelationsTableAnnotationComposer(
            $db: $db,
            $table: $db.conceptRelations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> crossReferencesRefs<T extends Object>(
    Expression<T> Function($$CrossReferencesTableAnnotationComposer a) f,
  ) {
    final $$CrossReferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.crossReferences,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrossReferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.crossReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> chatSessionsRefs<T extends Object>(
    Expression<T> Function($$ChatSessionsTableAnnotationComposer a) f,
  ) {
    final $$ChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> apiUsageLogRefs<T extends Object>(
    Expression<T> Function($$ApiUsageLogTableAnnotationComposer a) f,
  ) {
    final $$ApiUsageLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.apiUsageLog,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiUsageLogTableAnnotationComposer(
            $db: $db,
            $table: $db.apiUsageLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ProjectsTable,
          ProjectRow,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (ProjectRow, $$ProjectsTableReferences),
          ProjectRow,
          PrefetchHooks Function({
            bool documentsRefs,
            bool notebooksRefs,
            bool conceptsRefs,
            bool conceptRelationsRefs,
            bool crossReferencesRefs,
            bool chatSessionsRefs,
            bool apiUsageLogRefs,
          })
        > {
  $$ProjectsTableTableManager(_$LogoiDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String?> settings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                description: description,
                area: area,
                language: language,
                createdAt: createdAt,
                updatedAt: updatedAt,
                settings: settings,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String> language = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<String?> settings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                area: area,
                language: language,
                createdAt: createdAt,
                updatedAt: updatedAt,
                settings: settings,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                documentsRefs = false,
                notebooksRefs = false,
                conceptsRefs = false,
                conceptRelationsRefs = false,
                crossReferencesRefs = false,
                chatSessionsRefs = false,
                apiUsageLogRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (documentsRefs) db.documents,
                    if (notebooksRefs) db.notebooks,
                    if (conceptsRefs) db.concepts,
                    if (conceptRelationsRefs) db.conceptRelations,
                    if (crossReferencesRefs) db.crossReferences,
                    if (chatSessionsRefs) db.chatSessions,
                    if (apiUsageLogRefs) db.apiUsageLog,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (documentsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          DocumentRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (notebooksRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          NotebookRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._notebooksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).notebooksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (conceptsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          ConceptRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._conceptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).conceptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (conceptRelationsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          ConceptRelationRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._conceptRelationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).conceptRelationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (crossReferencesRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          CrossReferenceRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._crossReferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).crossReferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (chatSessionsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          ChatSessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._chatSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (apiUsageLogRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          ApiUsageLogRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._apiUsageLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).apiUsageLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ProjectsTable,
      ProjectRow,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (ProjectRow, $$ProjectsTableReferences),
      ProjectRow,
      PrefetchHooks Function({
        bool documentsRefs,
        bool notebooksRefs,
        bool conceptsRefs,
        bool conceptRelationsRefs,
        bool crossReferencesRefs,
        bool chatSessionsRefs,
        bool apiUsageLogRefs,
      })
    >;
typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      required String id,
      required String projectId,
      required String fileName,
      required String filePath,
      Value<String?> title,
      Value<String?> authors,
      Value<int?> year,
      Value<int?> totalPages,
      Value<int> lastReadPage,
      Value<String> processingStatus,
      required int importedAt,
      Value<String?> metadata,
      Value<int> rowid,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> fileName,
      Value<String> filePath,
      Value<String?> title,
      Value<String?> authors,
      Value<int?> year,
      Value<int?> totalPages,
      Value<int> lastReadPage,
      Value<String> processingStatus,
      Value<int> importedAt,
      Value<String?> metadata,
      Value<int> rowid,
    });

final class $$DocumentsTableReferences
    extends BaseReferences<_$LogoiDatabase, $DocumentsTable, DocumentRow> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$LogoiDatabase db) =>
      db.projects.createAlias('documents__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PageContentsTable, List<PageContentRow>>
  _pageContentsRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.pageContents,
    aliasName: 'documents__id__page_contents__document_id',
  );

  $$PageContentsTableProcessedTableManager get pageContentsRefs {
    final manager = $$PageContentsTableTableManager(
      $_db,
      $_db.pageContents,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pageContentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ParagraphsTable, List<ParagraphRow>>
  _paragraphsRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.paragraphs,
    aliasName: 'documents__id__paragraphs__document_id',
  );

  $$ParagraphsTableProcessedTableManager get paragraphsRefs {
    final manager = $$ParagraphsTableTableManager(
      $_db,
      $_db.paragraphs,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paragraphsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentStructureTable, List<StructureRow>>
  _documentStructureRefsTable(_$LogoiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentStructure,
        aliasName: 'documents__id__document_structure__document_id',
      );

  $$DocumentStructureTableProcessedTableManager get documentStructureRefs {
    final manager = $$DocumentStructureTableTableManager(
      $_db,
      $_db.documentStructure,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _documentStructureRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnnotationsTable, List<AnnotationRow>>
  _annotationsRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.annotations,
    aliasName: 'documents__id__annotations__document_id',
  );

  $$AnnotationsTableProcessedTableManager get annotationsRefs {
    final manager = $$AnnotationsTableTableManager(
      $_db,
      $_db.annotations,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_annotationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotebooksTable, List<NotebookRow>>
  _notebooksRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.notebooks,
    aliasName: 'documents__id__notebooks__document_id',
  );

  $$NotebooksTableProcessedTableManager get notebooksRefs {
    final manager = $$NotebooksTableTableManager(
      $_db,
      $_db.notebooks,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_notebooksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatSessionsTable, List<ChatSessionRow>>
  _chatSessionsRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.chatSessions,
    aliasName: 'documents__id__chat_sessions__document_id',
  );

  $$ChatSessionsTableProcessedTableManager get chatSessionsRefs {
    final manager = $$ChatSessionsTableTableManager(
      $_db,
      $_db.chatSessions,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ApiUsageLogTable, List<ApiUsageLogRow>>
  _apiUsageLogRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.apiUsageLog,
    aliasName: 'documents__id__api_usage_log__document_id',
  );

  $$ApiUsageLogTableProcessedTableManager get apiUsageLogRefs {
    final manager = $$ApiUsageLogTableTableManager(
      $_db,
      $_db.apiUsageLog,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_apiUsageLogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingSessionsTable, List<ReadingSessionRow>>
  _readingSessionsRefsTable(_$LogoiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.readingSessions,
        aliasName: 'documents__id__reading_sessions__document_id',
      );

  $$ReadingSessionsTableProcessedTableManager get readingSessionsRefs {
    final manager = $$ReadingSessionsTableTableManager(
      $_db,
      $_db.readingSessions,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$LogoiDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authors => $composableBuilder(
    column: $table.authors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReadPage => $composableBuilder(
    column: $table.lastReadPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pageContentsRefs(
    Expression<bool> Function($$PageContentsTableFilterComposer f) f,
  ) {
    final $$PageContentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pageContents,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PageContentsTableFilterComposer(
            $db: $db,
            $table: $db.pageContents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paragraphsRefs(
    Expression<bool> Function($$ParagraphsTableFilterComposer f) f,
  ) {
    final $$ParagraphsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paragraphs,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphsTableFilterComposer(
            $db: $db,
            $table: $db.paragraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentStructureRefs(
    Expression<bool> Function($$DocumentStructureTableFilterComposer f) f,
  ) {
    final $$DocumentStructureTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentStructure,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentStructureTableFilterComposer(
            $db: $db,
            $table: $db.documentStructure,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> annotationsRefs(
    Expression<bool> Function($$AnnotationsTableFilterComposer f) f,
  ) {
    final $$AnnotationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.annotations,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnotationsTableFilterComposer(
            $db: $db,
            $table: $db.annotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notebooksRefs(
    Expression<bool> Function($$NotebooksTableFilterComposer f) f,
  ) {
    final $$NotebooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableFilterComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> chatSessionsRefs(
    Expression<bool> Function($$ChatSessionsTableFilterComposer f) f,
  ) {
    final $$ChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> apiUsageLogRefs(
    Expression<bool> Function($$ApiUsageLogTableFilterComposer f) f,
  ) {
    final $$ApiUsageLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.apiUsageLog,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiUsageLogTableFilterComposer(
            $db: $db,
            $table: $db.apiUsageLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingSessionsRefs(
    Expression<bool> Function($$ReadingSessionsTableFilterComposer f) f,
  ) {
    final $$ReadingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingSessions,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.readingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authors => $composableBuilder(
    column: $table.authors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReadPage => $composableBuilder(
    column: $table.lastReadPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get authors =>
      $composableBuilder(column: $table.authors, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastReadPage => $composableBuilder(
    column: $table.lastReadPage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pageContentsRefs<T extends Object>(
    Expression<T> Function($$PageContentsTableAnnotationComposer a) f,
  ) {
    final $$PageContentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pageContents,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PageContentsTableAnnotationComposer(
            $db: $db,
            $table: $db.pageContents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paragraphsRefs<T extends Object>(
    Expression<T> Function($$ParagraphsTableAnnotationComposer a) f,
  ) {
    final $$ParagraphsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paragraphs,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphsTableAnnotationComposer(
            $db: $db,
            $table: $db.paragraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentStructureRefs<T extends Object>(
    Expression<T> Function($$DocumentStructureTableAnnotationComposer a) f,
  ) {
    final $$DocumentStructureTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.documentStructure,
          getReferencedColumn: (t) => t.documentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentStructureTableAnnotationComposer(
                $db: $db,
                $table: $db.documentStructure,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> annotationsRefs<T extends Object>(
    Expression<T> Function($$AnnotationsTableAnnotationComposer a) f,
  ) {
    final $$AnnotationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.annotations,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnotationsTableAnnotationComposer(
            $db: $db,
            $table: $db.annotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notebooksRefs<T extends Object>(
    Expression<T> Function($$NotebooksTableAnnotationComposer a) f,
  ) {
    final $$NotebooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notebooks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotebooksTableAnnotationComposer(
            $db: $db,
            $table: $db.notebooks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> chatSessionsRefs<T extends Object>(
    Expression<T> Function($$ChatSessionsTableAnnotationComposer a) f,
  ) {
    final $$ChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> apiUsageLogRefs<T extends Object>(
    Expression<T> Function($$ApiUsageLogTableAnnotationComposer a) f,
  ) {
    final $$ApiUsageLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.apiUsageLog,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiUsageLogTableAnnotationComposer(
            $db: $db,
            $table: $db.apiUsageLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingSessionsRefs<T extends Object>(
    Expression<T> Function($$ReadingSessionsTableAnnotationComposer a) f,
  ) {
    final $$ReadingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingSessions,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.readingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $DocumentsTable,
          DocumentRow,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (DocumentRow, $$DocumentsTableReferences),
          DocumentRow,
          PrefetchHooks Function({
            bool projectId,
            bool pageContentsRefs,
            bool paragraphsRefs,
            bool documentStructureRefs,
            bool annotationsRefs,
            bool notebooksRefs,
            bool chatSessionsRefs,
            bool apiUsageLogRefs,
            bool readingSessionsRefs,
          })
        > {
  $$DocumentsTableTableManager(_$LogoiDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> authors = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int?> totalPages = const Value.absent(),
                Value<int> lastReadPage = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                Value<int> importedAt = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                projectId: projectId,
                fileName: fileName,
                filePath: filePath,
                title: title,
                authors: authors,
                year: year,
                totalPages: totalPages,
                lastReadPage: lastReadPage,
                processingStatus: processingStatus,
                importedAt: importedAt,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String fileName,
                required String filePath,
                Value<String?> title = const Value.absent(),
                Value<String?> authors = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int?> totalPages = const Value.absent(),
                Value<int> lastReadPage = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                required int importedAt,
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                projectId: projectId,
                fileName: fileName,
                filePath: filePath,
                title: title,
                authors: authors,
                year: year,
                totalPages: totalPages,
                lastReadPage: lastReadPage,
                processingStatus: processingStatus,
                importedAt: importedAt,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectId = false,
                pageContentsRefs = false,
                paragraphsRefs = false,
                documentStructureRefs = false,
                annotationsRefs = false,
                notebooksRefs = false,
                chatSessionsRefs = false,
                apiUsageLogRefs = false,
                readingSessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pageContentsRefs) db.pageContents,
                    if (paragraphsRefs) db.paragraphs,
                    if (documentStructureRefs) db.documentStructure,
                    if (annotationsRefs) db.annotations,
                    if (notebooksRefs) db.notebooks,
                    if (chatSessionsRefs) db.chatSessions,
                    if (apiUsageLogRefs) db.apiUsageLog,
                    if (readingSessionsRefs) db.readingSessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable: $$DocumentsTableReferences
                                        ._projectIdTable(db),
                                    referencedColumn: $$DocumentsTableReferences
                                        ._projectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pageContentsRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          PageContentRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._pageContentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).pageContentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paragraphsRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          ParagraphRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._paragraphsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).paragraphsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentStructureRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          StructureRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._documentStructureRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentStructureRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (annotationsRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          AnnotationRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._annotationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).annotationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (notebooksRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          NotebookRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._notebooksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).notebooksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (chatSessionsRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          ChatSessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._chatSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (apiUsageLogRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          ApiUsageLogRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._apiUsageLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).apiUsageLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (readingSessionsRefs)
                        await $_getPrefetchedData<
                          DocumentRow,
                          $DocumentsTable,
                          ReadingSessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._readingSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).readingSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $DocumentsTable,
      DocumentRow,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (DocumentRow, $$DocumentsTableReferences),
      DocumentRow,
      PrefetchHooks Function({
        bool projectId,
        bool pageContentsRefs,
        bool paragraphsRefs,
        bool documentStructureRefs,
        bool annotationsRefs,
        bool notebooksRefs,
        bool chatSessionsRefs,
        bool apiUsageLogRefs,
        bool readingSessionsRefs,
      })
    >;
typedef $$PageContentsTableCreateCompanionBuilder =
    PageContentsCompanion Function({
      required String id,
      required String documentId,
      required int pageNumber,
      required String content,
      Value<String> source,
      Value<int> rowid,
    });
typedef $$PageContentsTableUpdateCompanionBuilder =
    PageContentsCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> pageNumber,
      Value<String> content,
      Value<String> source,
      Value<int> rowid,
    });

final class $$PageContentsTableReferences
    extends
        BaseReferences<_$LogoiDatabase, $PageContentsTable, PageContentRow> {
  $$PageContentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) =>
      db.documents.createAlias('page_contents__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PageContentsTableFilterComposer
    extends Composer<_$LogoiDatabase, $PageContentsTable> {
  $$PageContentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PageContentsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $PageContentsTable> {
  $$PageContentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PageContentsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $PageContentsTable> {
  $$PageContentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PageContentsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $PageContentsTable,
          PageContentRow,
          $$PageContentsTableFilterComposer,
          $$PageContentsTableOrderingComposer,
          $$PageContentsTableAnnotationComposer,
          $$PageContentsTableCreateCompanionBuilder,
          $$PageContentsTableUpdateCompanionBuilder,
          (PageContentRow, $$PageContentsTableReferences),
          PageContentRow,
          PrefetchHooks Function({bool documentId})
        > {
  $$PageContentsTableTableManager(_$LogoiDatabase db, $PageContentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PageContentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PageContentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PageContentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PageContentsCompanion(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                content: content,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int pageNumber,
                required String content,
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PageContentsCompanion.insert(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                content: content,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PageContentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$PageContentsTableReferences
                                    ._documentIdTable(db),
                                referencedColumn: $$PageContentsTableReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PageContentsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $PageContentsTable,
      PageContentRow,
      $$PageContentsTableFilterComposer,
      $$PageContentsTableOrderingComposer,
      $$PageContentsTableAnnotationComposer,
      $$PageContentsTableCreateCompanionBuilder,
      $$PageContentsTableUpdateCompanionBuilder,
      (PageContentRow, $$PageContentsTableReferences),
      PageContentRow,
      PrefetchHooks Function({bool documentId})
    >;
typedef $$ParagraphsTableCreateCompanionBuilder =
    ParagraphsCompanion Function({
      required String id,
      required String documentId,
      required int pageNumber,
      required int paragraphIndex,
      required String content,
      Value<String?> compressedText,
      Value<int> rowid,
    });
typedef $$ParagraphsTableUpdateCompanionBuilder =
    ParagraphsCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> pageNumber,
      Value<int> paragraphIndex,
      Value<String> content,
      Value<String?> compressedText,
      Value<int> rowid,
    });

final class $$ParagraphsTableReferences
    extends BaseReferences<_$LogoiDatabase, $ParagraphsTable, ParagraphRow> {
  $$ParagraphsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) =>
      db.documents.createAlias('paragraphs__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ParagraphEmbeddingsTable,
    List<ParagraphEmbeddingRow>
  >
  _paragraphEmbeddingsRefsTable(_$LogoiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paragraphEmbeddings,
        aliasName: 'paragraphs__id__paragraph_embeddings__paragraph_id',
      );

  $$ParagraphEmbeddingsTableProcessedTableManager get paragraphEmbeddingsRefs {
    final manager = $$ParagraphEmbeddingsTableTableManager(
      $_db,
      $_db.paragraphEmbeddings,
    ).filter((f) => f.paragraphId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paragraphEmbeddingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ParagraphsTableFilterComposer
    extends Composer<_$LogoiDatabase, $ParagraphsTable> {
  $$ParagraphsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paragraphIndex => $composableBuilder(
    column: $table.paragraphIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compressedText => $composableBuilder(
    column: $table.compressedText,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paragraphEmbeddingsRefs(
    Expression<bool> Function($$ParagraphEmbeddingsTableFilterComposer f) f,
  ) {
    final $$ParagraphEmbeddingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paragraphEmbeddings,
      getReferencedColumn: (t) => t.paragraphId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphEmbeddingsTableFilterComposer(
            $db: $db,
            $table: $db.paragraphEmbeddings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParagraphsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ParagraphsTable> {
  $$ParagraphsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paragraphIndex => $composableBuilder(
    column: $table.paragraphIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compressedText => $composableBuilder(
    column: $table.compressedText,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParagraphsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ParagraphsTable> {
  $$ParagraphsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paragraphIndex => $composableBuilder(
    column: $table.paragraphIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get compressedText => $composableBuilder(
    column: $table.compressedText,
    builder: (column) => column,
  );

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paragraphEmbeddingsRefs<T extends Object>(
    Expression<T> Function($$ParagraphEmbeddingsTableAnnotationComposer a) f,
  ) {
    final $$ParagraphEmbeddingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paragraphEmbeddings,
          getReferencedColumn: (t) => t.paragraphId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParagraphEmbeddingsTableAnnotationComposer(
                $db: $db,
                $table: $db.paragraphEmbeddings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ParagraphsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ParagraphsTable,
          ParagraphRow,
          $$ParagraphsTableFilterComposer,
          $$ParagraphsTableOrderingComposer,
          $$ParagraphsTableAnnotationComposer,
          $$ParagraphsTableCreateCompanionBuilder,
          $$ParagraphsTableUpdateCompanionBuilder,
          (ParagraphRow, $$ParagraphsTableReferences),
          ParagraphRow,
          PrefetchHooks Function({
            bool documentId,
            bool paragraphEmbeddingsRefs,
          })
        > {
  $$ParagraphsTableTableManager(_$LogoiDatabase db, $ParagraphsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParagraphsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParagraphsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParagraphsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
                Value<int> paragraphIndex = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> compressedText = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParagraphsCompanion(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                paragraphIndex: paragraphIndex,
                content: content,
                compressedText: compressedText,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int pageNumber,
                required int paragraphIndex,
                required String content,
                Value<String?> compressedText = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParagraphsCompanion.insert(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                paragraphIndex: paragraphIndex,
                content: content,
                compressedText: compressedText,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ParagraphsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({documentId = false, paragraphEmbeddingsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (paragraphEmbeddingsRefs) db.paragraphEmbeddings,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable: $$ParagraphsTableReferences
                                        ._documentIdTable(db),
                                    referencedColumn:
                                        $$ParagraphsTableReferences
                                            ._documentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paragraphEmbeddingsRefs)
                        await $_getPrefetchedData<
                          ParagraphRow,
                          $ParagraphsTable,
                          ParagraphEmbeddingRow
                        >(
                          currentTable: table,
                          referencedTable: $$ParagraphsTableReferences
                              ._paragraphEmbeddingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ParagraphsTableReferences(
                                db,
                                table,
                                p0,
                              ).paragraphEmbeddingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.paragraphId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ParagraphsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ParagraphsTable,
      ParagraphRow,
      $$ParagraphsTableFilterComposer,
      $$ParagraphsTableOrderingComposer,
      $$ParagraphsTableAnnotationComposer,
      $$ParagraphsTableCreateCompanionBuilder,
      $$ParagraphsTableUpdateCompanionBuilder,
      (ParagraphRow, $$ParagraphsTableReferences),
      ParagraphRow,
      PrefetchHooks Function({bool documentId, bool paragraphEmbeddingsRefs})
    >;
typedef $$ParagraphEmbeddingsTableCreateCompanionBuilder =
    ParagraphEmbeddingsCompanion Function({
      required String id,
      required String paragraphId,
      required Uint8List embedding,
      required String model,
      required int dimensions,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$ParagraphEmbeddingsTableUpdateCompanionBuilder =
    ParagraphEmbeddingsCompanion Function({
      Value<String> id,
      Value<String> paragraphId,
      Value<Uint8List> embedding,
      Value<String> model,
      Value<int> dimensions,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$ParagraphEmbeddingsTableReferences
    extends
        BaseReferences<
          _$LogoiDatabase,
          $ParagraphEmbeddingsTable,
          ParagraphEmbeddingRow
        > {
  $$ParagraphEmbeddingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ParagraphsTable _paragraphIdTable(_$LogoiDatabase db) => db.paragraphs
      .createAlias('paragraph_embeddings__paragraph_id__paragraphs__id');

  $$ParagraphsTableProcessedTableManager get paragraphId {
    final $_column = $_itemColumn<String>('paragraph_id')!;

    final manager = $$ParagraphsTableTableManager(
      $_db,
      $_db.paragraphs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paragraphIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParagraphEmbeddingsTableFilterComposer
    extends Composer<_$LogoiDatabase, $ParagraphEmbeddingsTable> {
  $$ParagraphEmbeddingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get embedding => $composableBuilder(
    column: $table.embedding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dimensions => $composableBuilder(
    column: $table.dimensions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ParagraphsTableFilterComposer get paragraphId {
    final $$ParagraphsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paragraphId,
      referencedTable: $db.paragraphs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphsTableFilterComposer(
            $db: $db,
            $table: $db.paragraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParagraphEmbeddingsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ParagraphEmbeddingsTable> {
  $$ParagraphEmbeddingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get embedding => $composableBuilder(
    column: $table.embedding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dimensions => $composableBuilder(
    column: $table.dimensions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParagraphsTableOrderingComposer get paragraphId {
    final $$ParagraphsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paragraphId,
      referencedTable: $db.paragraphs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphsTableOrderingComposer(
            $db: $db,
            $table: $db.paragraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParagraphEmbeddingsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ParagraphEmbeddingsTable> {
  $$ParagraphEmbeddingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get embedding =>
      $composableBuilder(column: $table.embedding, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get dimensions => $composableBuilder(
    column: $table.dimensions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ParagraphsTableAnnotationComposer get paragraphId {
    final $$ParagraphsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paragraphId,
      referencedTable: $db.paragraphs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParagraphsTableAnnotationComposer(
            $db: $db,
            $table: $db.paragraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParagraphEmbeddingsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ParagraphEmbeddingsTable,
          ParagraphEmbeddingRow,
          $$ParagraphEmbeddingsTableFilterComposer,
          $$ParagraphEmbeddingsTableOrderingComposer,
          $$ParagraphEmbeddingsTableAnnotationComposer,
          $$ParagraphEmbeddingsTableCreateCompanionBuilder,
          $$ParagraphEmbeddingsTableUpdateCompanionBuilder,
          (ParagraphEmbeddingRow, $$ParagraphEmbeddingsTableReferences),
          ParagraphEmbeddingRow,
          PrefetchHooks Function({bool paragraphId})
        > {
  $$ParagraphEmbeddingsTableTableManager(
    _$LogoiDatabase db,
    $ParagraphEmbeddingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParagraphEmbeddingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParagraphEmbeddingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ParagraphEmbeddingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> paragraphId = const Value.absent(),
                Value<Uint8List> embedding = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> dimensions = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParagraphEmbeddingsCompanion(
                id: id,
                paragraphId: paragraphId,
                embedding: embedding,
                model: model,
                dimensions: dimensions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String paragraphId,
                required Uint8List embedding,
                required String model,
                required int dimensions,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ParagraphEmbeddingsCompanion.insert(
                id: id,
                paragraphId: paragraphId,
                embedding: embedding,
                model: model,
                dimensions: dimensions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ParagraphEmbeddingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paragraphId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (paragraphId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.paragraphId,
                                referencedTable:
                                    $$ParagraphEmbeddingsTableReferences
                                        ._paragraphIdTable(db),
                                referencedColumn:
                                    $$ParagraphEmbeddingsTableReferences
                                        ._paragraphIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParagraphEmbeddingsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ParagraphEmbeddingsTable,
      ParagraphEmbeddingRow,
      $$ParagraphEmbeddingsTableFilterComposer,
      $$ParagraphEmbeddingsTableOrderingComposer,
      $$ParagraphEmbeddingsTableAnnotationComposer,
      $$ParagraphEmbeddingsTableCreateCompanionBuilder,
      $$ParagraphEmbeddingsTableUpdateCompanionBuilder,
      (ParagraphEmbeddingRow, $$ParagraphEmbeddingsTableReferences),
      ParagraphEmbeddingRow,
      PrefetchHooks Function({bool paragraphId})
    >;
typedef $$DocumentStructureTableCreateCompanionBuilder =
    DocumentStructureCompanion Function({
      required String id,
      required String documentId,
      Value<String?> parentId,
      required int level,
      Value<String?> title,
      required int pageStart,
      required int pageEnd,
      required int orderIndex,
      Value<String> processingStatus,
      Value<int> rowid,
    });
typedef $$DocumentStructureTableUpdateCompanionBuilder =
    DocumentStructureCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String?> parentId,
      Value<int> level,
      Value<String?> title,
      Value<int> pageStart,
      Value<int> pageEnd,
      Value<int> orderIndex,
      Value<String> processingStatus,
      Value<int> rowid,
    });

final class $$DocumentStructureTableReferences
    extends
        BaseReferences<_$LogoiDatabase, $DocumentStructureTable, StructureRow> {
  $$DocumentStructureTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) => db.documents
      .createAlias('document_structure__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentStructureTable _parentIdTable(_$LogoiDatabase db) => db
      .documentStructure
      .createAlias('document_structure__parent_id__document_structure__id');

  $$DocumentStructureTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$DocumentStructureTableTableManager(
      $_db,
      $_db.documentStructure,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SectionSummariesTable, List<SectionSummaryRow>>
  _sectionSummariesRefsTable(_$LogoiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sectionSummaries,
        aliasName: 'document_structure__id__section_summaries__structure_id',
      );

  $$SectionSummariesTableProcessedTableManager get sectionSummariesRefs {
    final manager = $$SectionSummariesTableTableManager(
      $_db,
      $_db.sectionSummaries,
    ).filter((f) => f.structureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionSummariesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentStructureTableFilterComposer
    extends Composer<_$LogoiDatabase, $DocumentStructureTable> {
  $$DocumentStructureTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageStart => $composableBuilder(
    column: $table.pageStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageEnd => $composableBuilder(
    column: $table.pageEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentStructureTableFilterComposer get parentId {
    final $$DocumentStructureTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.documentStructure,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentStructureTableFilterComposer(
            $db: $db,
            $table: $db.documentStructure,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sectionSummariesRefs(
    Expression<bool> Function($$SectionSummariesTableFilterComposer f) f,
  ) {
    final $$SectionSummariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionSummaries,
      getReferencedColumn: (t) => t.structureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionSummariesTableFilterComposer(
            $db: $db,
            $table: $db.sectionSummaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentStructureTableOrderingComposer
    extends Composer<_$LogoiDatabase, $DocumentStructureTable> {
  $$DocumentStructureTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageStart => $composableBuilder(
    column: $table.pageStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageEnd => $composableBuilder(
    column: $table.pageEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentStructureTableOrderingComposer get parentId {
    final $$DocumentStructureTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.documentStructure,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentStructureTableOrderingComposer(
            $db: $db,
            $table: $db.documentStructure,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentStructureTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $DocumentStructureTable> {
  $$DocumentStructureTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get pageStart =>
      $composableBuilder(column: $table.pageStart, builder: (column) => column);

  GeneratedColumn<int> get pageEnd =>
      $composableBuilder(column: $table.pageEnd, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => column,
  );

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentStructureTableAnnotationComposer get parentId {
    final $$DocumentStructureTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.parentId,
          referencedTable: $db.documentStructure,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentStructureTableAnnotationComposer(
                $db: $db,
                $table: $db.documentStructure,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> sectionSummariesRefs<T extends Object>(
    Expression<T> Function($$SectionSummariesTableAnnotationComposer a) f,
  ) {
    final $$SectionSummariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionSummaries,
      getReferencedColumn: (t) => t.structureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionSummariesTableAnnotationComposer(
            $db: $db,
            $table: $db.sectionSummaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentStructureTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $DocumentStructureTable,
          StructureRow,
          $$DocumentStructureTableFilterComposer,
          $$DocumentStructureTableOrderingComposer,
          $$DocumentStructureTableAnnotationComposer,
          $$DocumentStructureTableCreateCompanionBuilder,
          $$DocumentStructureTableUpdateCompanionBuilder,
          (StructureRow, $$DocumentStructureTableReferences),
          StructureRow,
          PrefetchHooks Function({
            bool documentId,
            bool parentId,
            bool sectionSummariesRefs,
          })
        > {
  $$DocumentStructureTableTableManager(
    _$LogoiDatabase db,
    $DocumentStructureTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentStructureTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentStructureTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentStructureTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<int> pageStart = const Value.absent(),
                Value<int> pageEnd = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentStructureCompanion(
                id: id,
                documentId: documentId,
                parentId: parentId,
                level: level,
                title: title,
                pageStart: pageStart,
                pageEnd: pageEnd,
                orderIndex: orderIndex,
                processingStatus: processingStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                Value<String?> parentId = const Value.absent(),
                required int level,
                Value<String?> title = const Value.absent(),
                required int pageStart,
                required int pageEnd,
                required int orderIndex,
                Value<String> processingStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentStructureCompanion.insert(
                id: id,
                documentId: documentId,
                parentId: parentId,
                level: level,
                title: title,
                pageStart: pageStart,
                pageEnd: pageEnd,
                orderIndex: orderIndex,
                processingStatus: processingStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentStructureTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                documentId = false,
                parentId = false,
                sectionSummariesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sectionSummariesRefs) db.sectionSummaries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable:
                                        $$DocumentStructureTableReferences
                                            ._documentIdTable(db),
                                    referencedColumn:
                                        $$DocumentStructureTableReferences
                                            ._documentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (parentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentId,
                                    referencedTable:
                                        $$DocumentStructureTableReferences
                                            ._parentIdTable(db),
                                    referencedColumn:
                                        $$DocumentStructureTableReferences
                                            ._parentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sectionSummariesRefs)
                        await $_getPrefetchedData<
                          StructureRow,
                          $DocumentStructureTable,
                          SectionSummaryRow
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentStructureTableReferences
                              ._sectionSummariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentStructureTableReferences(
                                db,
                                table,
                                p0,
                              ).sectionSummariesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.structureId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DocumentStructureTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $DocumentStructureTable,
      StructureRow,
      $$DocumentStructureTableFilterComposer,
      $$DocumentStructureTableOrderingComposer,
      $$DocumentStructureTableAnnotationComposer,
      $$DocumentStructureTableCreateCompanionBuilder,
      $$DocumentStructureTableUpdateCompanionBuilder,
      (StructureRow, $$DocumentStructureTableReferences),
      StructureRow,
      PrefetchHooks Function({
        bool documentId,
        bool parentId,
        bool sectionSummariesRefs,
      })
    >;
typedef $$SectionSummariesTableCreateCompanionBuilder =
    SectionSummariesCompanion Function({
      required String id,
      required String structureId,
      Value<String?> compressedText,
      Value<String?> summary,
      Value<String?> keyConcepts,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      Value<String?> provider,
      Value<String?> model,
      Value<String?> promptVersion,
      Value<int?> generatedAt,
      Value<String?> cacheHash,
      Value<int> rowid,
    });
typedef $$SectionSummariesTableUpdateCompanionBuilder =
    SectionSummariesCompanion Function({
      Value<String> id,
      Value<String> structureId,
      Value<String?> compressedText,
      Value<String?> summary,
      Value<String?> keyConcepts,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      Value<String?> provider,
      Value<String?> model,
      Value<String?> promptVersion,
      Value<int?> generatedAt,
      Value<String?> cacheHash,
      Value<int> rowid,
    });

final class $$SectionSummariesTableReferences
    extends
        BaseReferences<
          _$LogoiDatabase,
          $SectionSummariesTable,
          SectionSummaryRow
        > {
  $$SectionSummariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentStructureTable _structureIdTable(_$LogoiDatabase db) => db
      .documentStructure
      .createAlias('section_summaries__structure_id__document_structure__id');

  $$DocumentStructureTableProcessedTableManager get structureId {
    final $_column = $_itemColumn<String>('structure_id')!;

    final manager = $$DocumentStructureTableTableManager(
      $_db,
      $_db.documentStructure,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_structureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SectionSummariesTableFilterComposer
    extends Composer<_$LogoiDatabase, $SectionSummariesTable> {
  $$SectionSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compressedText => $composableBuilder(
    column: $table.compressedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyConcepts => $composableBuilder(
    column: $table.keyConcepts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cacheHash => $composableBuilder(
    column: $table.cacheHash,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentStructureTableFilterComposer get structureId {
    final $$DocumentStructureTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.structureId,
      referencedTable: $db.documentStructure,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentStructureTableFilterComposer(
            $db: $db,
            $table: $db.documentStructure,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionSummariesTableOrderingComposer
    extends Composer<_$LogoiDatabase, $SectionSummariesTable> {
  $$SectionSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compressedText => $composableBuilder(
    column: $table.compressedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyConcepts => $composableBuilder(
    column: $table.keyConcepts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cacheHash => $composableBuilder(
    column: $table.cacheHash,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentStructureTableOrderingComposer get structureId {
    final $$DocumentStructureTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.structureId,
      referencedTable: $db.documentStructure,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentStructureTableOrderingComposer(
            $db: $db,
            $table: $db.documentStructure,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionSummariesTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $SectionSummariesTable> {
  $$SectionSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get compressedText => $composableBuilder(
    column: $table.compressedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get keyConcepts => $composableBuilder(
    column: $table.keyConcepts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cacheHash =>
      $composableBuilder(column: $table.cacheHash, builder: (column) => column);

  $$DocumentStructureTableAnnotationComposer get structureId {
    final $$DocumentStructureTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.structureId,
          referencedTable: $db.documentStructure,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentStructureTableAnnotationComposer(
                $db: $db,
                $table: $db.documentStructure,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SectionSummariesTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $SectionSummariesTable,
          SectionSummaryRow,
          $$SectionSummariesTableFilterComposer,
          $$SectionSummariesTableOrderingComposer,
          $$SectionSummariesTableAnnotationComposer,
          $$SectionSummariesTableCreateCompanionBuilder,
          $$SectionSummariesTableUpdateCompanionBuilder,
          (SectionSummaryRow, $$SectionSummariesTableReferences),
          SectionSummaryRow,
          PrefetchHooks Function({bool structureId})
        > {
  $$SectionSummariesTableTableManager(
    _$LogoiDatabase db,
    $SectionSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionSummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionSummariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> structureId = const Value.absent(),
                Value<String?> compressedText = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> keyConcepts = const Value.absent(),
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> promptVersion = const Value.absent(),
                Value<int?> generatedAt = const Value.absent(),
                Value<String?> cacheHash = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionSummariesCompanion(
                id: id,
                structureId: structureId,
                compressedText: compressedText,
                summary: summary,
                keyConcepts: keyConcepts,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                provider: provider,
                model: model,
                promptVersion: promptVersion,
                generatedAt: generatedAt,
                cacheHash: cacheHash,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String structureId,
                Value<String?> compressedText = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> keyConcepts = const Value.absent(),
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> promptVersion = const Value.absent(),
                Value<int?> generatedAt = const Value.absent(),
                Value<String?> cacheHash = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionSummariesCompanion.insert(
                id: id,
                structureId: structureId,
                compressedText: compressedText,
                summary: summary,
                keyConcepts: keyConcepts,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                provider: provider,
                model: model,
                promptVersion: promptVersion,
                generatedAt: generatedAt,
                cacheHash: cacheHash,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SectionSummariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({structureId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (structureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.structureId,
                                referencedTable:
                                    $$SectionSummariesTableReferences
                                        ._structureIdTable(db),
                                referencedColumn:
                                    $$SectionSummariesTableReferences
                                        ._structureIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SectionSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $SectionSummariesTable,
      SectionSummaryRow,
      $$SectionSummariesTableFilterComposer,
      $$SectionSummariesTableOrderingComposer,
      $$SectionSummariesTableAnnotationComposer,
      $$SectionSummariesTableCreateCompanionBuilder,
      $$SectionSummariesTableUpdateCompanionBuilder,
      (SectionSummaryRow, $$SectionSummariesTableReferences),
      SectionSummaryRow,
      PrefetchHooks Function({bool structureId})
    >;
typedef $$AnnotationsTableCreateCompanionBuilder =
    AnnotationsCompanion Function({
      required String id,
      required String documentId,
      required int pageNumber,
      required String type,
      Value<String?> color,
      Value<String?> selectedText,
      Value<String?> content,
      required String position,
      Value<String?> tags,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$AnnotationsTableUpdateCompanionBuilder =
    AnnotationsCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> pageNumber,
      Value<String> type,
      Value<String?> color,
      Value<String?> selectedText,
      Value<String?> content,
      Value<String> position,
      Value<String?> tags,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$AnnotationsTableReferences
    extends BaseReferences<_$LogoiDatabase, $AnnotationsTable, AnnotationRow> {
  $$AnnotationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) =>
      db.documents.createAlias('annotations__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $AnnotationVersionsTable,
    List<AnnotationVersionRow>
  >
  _annotationVersionsRefsTable(_$LogoiDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.annotationVersions,
        aliasName: 'annotations__id__annotation_versions__annotation_id',
      );

  $$AnnotationVersionsTableProcessedTableManager get annotationVersionsRefs {
    final manager = $$AnnotationVersionsTableTableManager(
      $_db,
      $_db.annotationVersions,
    ).filter((f) => f.annotationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _annotationVersionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AnnotationsTableFilterComposer
    extends Composer<_$LogoiDatabase, $AnnotationsTable> {
  $$AnnotationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> annotationVersionsRefs(
    Expression<bool> Function($$AnnotationVersionsTableFilterComposer f) f,
  ) {
    final $$AnnotationVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.annotationVersions,
      getReferencedColumn: (t) => t.annotationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnotationVersionsTableFilterComposer(
            $db: $db,
            $table: $db.annotationVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AnnotationsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $AnnotationsTable> {
  $$AnnotationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnnotationsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $AnnotationsTable> {
  $$AnnotationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> annotationVersionsRefs<T extends Object>(
    Expression<T> Function($$AnnotationVersionsTableAnnotationComposer a) f,
  ) {
    final $$AnnotationVersionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.annotationVersions,
          getReferencedColumn: (t) => t.annotationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AnnotationVersionsTableAnnotationComposer(
                $db: $db,
                $table: $db.annotationVersions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AnnotationsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $AnnotationsTable,
          AnnotationRow,
          $$AnnotationsTableFilterComposer,
          $$AnnotationsTableOrderingComposer,
          $$AnnotationsTableAnnotationComposer,
          $$AnnotationsTableCreateCompanionBuilder,
          $$AnnotationsTableUpdateCompanionBuilder,
          (AnnotationRow, $$AnnotationsTableReferences),
          AnnotationRow,
          PrefetchHooks Function({bool documentId, bool annotationVersionsRefs})
        > {
  $$AnnotationsTableTableManager(_$LogoiDatabase db, $AnnotationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnnotationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnnotationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnnotationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> selectedText = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnotationsCompanion(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                type: type,
                color: color,
                selectedText: selectedText,
                content: content,
                position: position,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int pageNumber,
                required String type,
                Value<String?> color = const Value.absent(),
                Value<String?> selectedText = const Value.absent(),
                Value<String?> content = const Value.absent(),
                required String position,
                Value<String?> tags = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AnnotationsCompanion.insert(
                id: id,
                documentId: documentId,
                pageNumber: pageNumber,
                type: type,
                color: color,
                selectedText: selectedText,
                content: content,
                position: position,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnnotationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({documentId = false, annotationVersionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (annotationVersionsRefs) db.annotationVersions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable:
                                        $$AnnotationsTableReferences
                                            ._documentIdTable(db),
                                    referencedColumn:
                                        $$AnnotationsTableReferences
                                            ._documentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (annotationVersionsRefs)
                        await $_getPrefetchedData<
                          AnnotationRow,
                          $AnnotationsTable,
                          AnnotationVersionRow
                        >(
                          currentTable: table,
                          referencedTable: $$AnnotationsTableReferences
                              ._annotationVersionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnnotationsTableReferences(
                                db,
                                table,
                                p0,
                              ).annotationVersionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.annotationId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AnnotationsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $AnnotationsTable,
      AnnotationRow,
      $$AnnotationsTableFilterComposer,
      $$AnnotationsTableOrderingComposer,
      $$AnnotationsTableAnnotationComposer,
      $$AnnotationsTableCreateCompanionBuilder,
      $$AnnotationsTableUpdateCompanionBuilder,
      (AnnotationRow, $$AnnotationsTableReferences),
      AnnotationRow,
      PrefetchHooks Function({bool documentId, bool annotationVersionsRefs})
    >;
typedef $$AnnotationVersionsTableCreateCompanionBuilder =
    AnnotationVersionsCompanion Function({
      required String id,
      required String annotationId,
      required String content,
      required int changedAt,
      Value<int> rowid,
    });
typedef $$AnnotationVersionsTableUpdateCompanionBuilder =
    AnnotationVersionsCompanion Function({
      Value<String> id,
      Value<String> annotationId,
      Value<String> content,
      Value<int> changedAt,
      Value<int> rowid,
    });

final class $$AnnotationVersionsTableReferences
    extends
        BaseReferences<
          _$LogoiDatabase,
          $AnnotationVersionsTable,
          AnnotationVersionRow
        > {
  $$AnnotationVersionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnnotationsTable _annotationIdTable(_$LogoiDatabase db) => db
      .annotations
      .createAlias('annotation_versions__annotation_id__annotations__id');

  $$AnnotationsTableProcessedTableManager get annotationId {
    final $_column = $_itemColumn<String>('annotation_id')!;

    final manager = $$AnnotationsTableTableManager(
      $_db,
      $_db.annotations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_annotationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AnnotationVersionsTableFilterComposer
    extends Composer<_$LogoiDatabase, $AnnotationVersionsTable> {
  $$AnnotationVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AnnotationsTableFilterComposer get annotationId {
    final $$AnnotationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.annotationId,
      referencedTable: $db.annotations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnotationsTableFilterComposer(
            $db: $db,
            $table: $db.annotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnnotationVersionsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $AnnotationVersionsTable> {
  $$AnnotationVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnnotationsTableOrderingComposer get annotationId {
    final $$AnnotationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.annotationId,
      referencedTable: $db.annotations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnotationsTableOrderingComposer(
            $db: $db,
            $table: $db.annotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnnotationVersionsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $AnnotationVersionsTable> {
  $$AnnotationVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  $$AnnotationsTableAnnotationComposer get annotationId {
    final $$AnnotationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.annotationId,
      referencedTable: $db.annotations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnotationsTableAnnotationComposer(
            $db: $db,
            $table: $db.annotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnnotationVersionsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $AnnotationVersionsTable,
          AnnotationVersionRow,
          $$AnnotationVersionsTableFilterComposer,
          $$AnnotationVersionsTableOrderingComposer,
          $$AnnotationVersionsTableAnnotationComposer,
          $$AnnotationVersionsTableCreateCompanionBuilder,
          $$AnnotationVersionsTableUpdateCompanionBuilder,
          (AnnotationVersionRow, $$AnnotationVersionsTableReferences),
          AnnotationVersionRow,
          PrefetchHooks Function({bool annotationId})
        > {
  $$AnnotationVersionsTableTableManager(
    _$LogoiDatabase db,
    $AnnotationVersionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnnotationVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnnotationVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnnotationVersionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> annotationId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> changedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnotationVersionsCompanion(
                id: id,
                annotationId: annotationId,
                content: content,
                changedAt: changedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String annotationId,
                required String content,
                required int changedAt,
                Value<int> rowid = const Value.absent(),
              }) => AnnotationVersionsCompanion.insert(
                id: id,
                annotationId: annotationId,
                content: content,
                changedAt: changedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnnotationVersionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({annotationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (annotationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.annotationId,
                                referencedTable:
                                    $$AnnotationVersionsTableReferences
                                        ._annotationIdTable(db),
                                referencedColumn:
                                    $$AnnotationVersionsTableReferences
                                        ._annotationIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AnnotationVersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $AnnotationVersionsTable,
      AnnotationVersionRow,
      $$AnnotationVersionsTableFilterComposer,
      $$AnnotationVersionsTableOrderingComposer,
      $$AnnotationVersionsTableAnnotationComposer,
      $$AnnotationVersionsTableCreateCompanionBuilder,
      $$AnnotationVersionsTableUpdateCompanionBuilder,
      (AnnotationVersionRow, $$AnnotationVersionsTableReferences),
      AnnotationVersionRow,
      PrefetchHooks Function({bool annotationId})
    >;
typedef $$NotebooksTableCreateCompanionBuilder =
    NotebooksCompanion Function({
      required String id,
      required String projectId,
      Value<String?> documentId,
      required String title,
      Value<String> content,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$NotebooksTableUpdateCompanionBuilder =
    NotebooksCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String?> documentId,
      Value<String> title,
      Value<String> content,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$NotebooksTableReferences
    extends BaseReferences<_$LogoiDatabase, $NotebooksTable, NotebookRow> {
  $$NotebooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$LogoiDatabase db) =>
      db.projects.createAlias('notebooks__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) =>
      db.documents.createAlias('notebooks__document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get documentId {
    final $_column = $_itemColumn<String>('document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotebooksTableFilterComposer
    extends Composer<_$LogoiDatabase, $NotebooksTable> {
  $$NotebooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotebooksTableOrderingComposer
    extends Composer<_$LogoiDatabase, $NotebooksTable> {
  $$NotebooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotebooksTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $NotebooksTable> {
  $$NotebooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotebooksTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $NotebooksTable,
          NotebookRow,
          $$NotebooksTableFilterComposer,
          $$NotebooksTableOrderingComposer,
          $$NotebooksTableAnnotationComposer,
          $$NotebooksTableCreateCompanionBuilder,
          $$NotebooksTableUpdateCompanionBuilder,
          (NotebookRow, $$NotebooksTableReferences),
          NotebookRow,
          PrefetchHooks Function({bool projectId, bool documentId})
        > {
  $$NotebooksTableTableManager(_$LogoiDatabase db, $NotebooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotebooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotebooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotebooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotebooksCompanion(
                id: id,
                projectId: projectId,
                documentId: documentId,
                title: title,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                Value<String?> documentId = const Value.absent(),
                required String title,
                Value<String> content = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotebooksCompanion.insert(
                id: id,
                projectId: projectId,
                documentId: documentId,
                title: title,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NotebooksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$NotebooksTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$NotebooksTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$NotebooksTableReferences
                                    ._documentIdTable(db),
                                referencedColumn: $$NotebooksTableReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotebooksTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $NotebooksTable,
      NotebookRow,
      $$NotebooksTableFilterComposer,
      $$NotebooksTableOrderingComposer,
      $$NotebooksTableAnnotationComposer,
      $$NotebooksTableCreateCompanionBuilder,
      $$NotebooksTableUpdateCompanionBuilder,
      (NotebookRow, $$NotebooksTableReferences),
      NotebookRow,
      PrefetchHooks Function({bool projectId, bool documentId})
    >;
typedef $$ConceptsTableCreateCompanionBuilder =
    ConceptsCompanion Function({
      required String id,
      required String projectId,
      required String name,
      Value<String?> definition,
      Value<String?> type,
      required String source,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$ConceptsTableUpdateCompanionBuilder =
    ConceptsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> name,
      Value<String?> definition,
      Value<String?> type,
      Value<String> source,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$ConceptsTableReferences
    extends BaseReferences<_$LogoiDatabase, $ConceptsTable, ConceptRow> {
  $$ConceptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$LogoiDatabase db) =>
      db.projects.createAlias('concepts__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConceptsTableFilterComposer
    extends Composer<_$LogoiDatabase, $ConceptsTable> {
  $$ConceptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConceptsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ConceptsTable> {
  $$ConceptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConceptsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ConceptsTable> {
  $$ConceptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConceptsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ConceptsTable,
          ConceptRow,
          $$ConceptsTableFilterComposer,
          $$ConceptsTableOrderingComposer,
          $$ConceptsTableAnnotationComposer,
          $$ConceptsTableCreateCompanionBuilder,
          $$ConceptsTableUpdateCompanionBuilder,
          (ConceptRow, $$ConceptsTableReferences),
          ConceptRow,
          PrefetchHooks Function({bool projectId})
        > {
  $$ConceptsTableTableManager(_$LogoiDatabase db, $ConceptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConceptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConceptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConceptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> definition = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConceptsCompanion(
                id: id,
                projectId: projectId,
                name: name,
                definition: definition,
                type: type,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String name,
                Value<String?> definition = const Value.absent(),
                Value<String?> type = const Value.absent(),
                required String source,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ConceptsCompanion.insert(
                id: id,
                projectId: projectId,
                name: name,
                definition: definition,
                type: type,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConceptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$ConceptsTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$ConceptsTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConceptsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ConceptsTable,
      ConceptRow,
      $$ConceptsTableFilterComposer,
      $$ConceptsTableOrderingComposer,
      $$ConceptsTableAnnotationComposer,
      $$ConceptsTableCreateCompanionBuilder,
      $$ConceptsTableUpdateCompanionBuilder,
      (ConceptRow, $$ConceptsTableReferences),
      ConceptRow,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$ConceptRelationsTableCreateCompanionBuilder =
    ConceptRelationsCompanion Function({
      required String id,
      required String projectId,
      required String sourceId,
      required String targetId,
      required String relation,
      Value<String?> description,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$ConceptRelationsTableUpdateCompanionBuilder =
    ConceptRelationsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> sourceId,
      Value<String> targetId,
      Value<String> relation,
      Value<String?> description,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$ConceptRelationsTableReferences
    extends
        BaseReferences<
          _$LogoiDatabase,
          $ConceptRelationsTable,
          ConceptRelationRow
        > {
  $$ConceptRelationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$LogoiDatabase db) =>
      db.projects.createAlias('concept_relations__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ConceptsTable _sourceIdTable(_$LogoiDatabase db) =>
      db.concepts.createAlias('concept_relations__source_id__concepts__id');

  $$ConceptsTableProcessedTableManager get sourceId {
    final $_column = $_itemColumn<String>('source_id')!;

    final manager = $$ConceptsTableTableManager(
      $_db,
      $_db.concepts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ConceptsTable _targetIdTable(_$LogoiDatabase db) =>
      db.concepts.createAlias('concept_relations__target_id__concepts__id');

  $$ConceptsTableProcessedTableManager get targetId {
    final $_column = $_itemColumn<String>('target_id')!;

    final manager = $$ConceptsTableTableManager(
      $_db,
      $_db.concepts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConceptRelationsTableFilterComposer
    extends Composer<_$LogoiDatabase, $ConceptRelationsTable> {
  $$ConceptRelationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ConceptsTableFilterComposer get sourceId {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ConceptsTableFilterComposer get targetId {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConceptRelationsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ConceptRelationsTable> {
  $$ConceptRelationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ConceptsTableOrderingComposer get sourceId {
    final $$ConceptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableOrderingComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ConceptsTableOrderingComposer get targetId {
    final $$ConceptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableOrderingComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConceptRelationsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ConceptRelationsTable> {
  $$ConceptRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ConceptsTableAnnotationComposer get sourceId {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ConceptsTableAnnotationComposer get targetId {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConceptRelationsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ConceptRelationsTable,
          ConceptRelationRow,
          $$ConceptRelationsTableFilterComposer,
          $$ConceptRelationsTableOrderingComposer,
          $$ConceptRelationsTableAnnotationComposer,
          $$ConceptRelationsTableCreateCompanionBuilder,
          $$ConceptRelationsTableUpdateCompanionBuilder,
          (ConceptRelationRow, $$ConceptRelationsTableReferences),
          ConceptRelationRow,
          PrefetchHooks Function({bool projectId, bool sourceId, bool targetId})
        > {
  $$ConceptRelationsTableTableManager(
    _$LogoiDatabase db,
    $ConceptRelationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConceptRelationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConceptRelationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConceptRelationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> targetId = const Value.absent(),
                Value<String> relation = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConceptRelationsCompanion(
                id: id,
                projectId: projectId,
                sourceId: sourceId,
                targetId: targetId,
                relation: relation,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String sourceId,
                required String targetId,
                required String relation,
                Value<String?> description = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ConceptRelationsCompanion.insert(
                id: id,
                projectId: projectId,
                sourceId: sourceId,
                targetId: targetId,
                relation: relation,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConceptRelationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectId = false, sourceId = false, targetId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$ConceptRelationsTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$ConceptRelationsTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (sourceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceId,
                                    referencedTable:
                                        $$ConceptRelationsTableReferences
                                            ._sourceIdTable(db),
                                    referencedColumn:
                                        $$ConceptRelationsTableReferences
                                            ._sourceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (targetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.targetId,
                                    referencedTable:
                                        $$ConceptRelationsTableReferences
                                            ._targetIdTable(db),
                                    referencedColumn:
                                        $$ConceptRelationsTableReferences
                                            ._targetIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ConceptRelationsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ConceptRelationsTable,
      ConceptRelationRow,
      $$ConceptRelationsTableFilterComposer,
      $$ConceptRelationsTableOrderingComposer,
      $$ConceptRelationsTableAnnotationComposer,
      $$ConceptRelationsTableCreateCompanionBuilder,
      $$ConceptRelationsTableUpdateCompanionBuilder,
      (ConceptRelationRow, $$ConceptRelationsTableReferences),
      ConceptRelationRow,
      PrefetchHooks Function({bool projectId, bool sourceId, bool targetId})
    >;
typedef $$CrossReferencesTableCreateCompanionBuilder =
    CrossReferencesCompanion Function({
      required String id,
      required String projectId,
      required String sourceDocId,
      required int sourcePage,
      required String sourceText,
      required String targetDocId,
      required int targetPage,
      required String targetText,
      required String relationType,
      Value<double?> confidence,
      Value<String> sourceOrigin,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CrossReferencesTableUpdateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> sourceDocId,
      Value<int> sourcePage,
      Value<String> sourceText,
      Value<String> targetDocId,
      Value<int> targetPage,
      Value<String> targetText,
      Value<String> relationType,
      Value<double?> confidence,
      Value<String> sourceOrigin,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CrossReferencesTableReferences
    extends
        BaseReferences<
          _$LogoiDatabase,
          $CrossReferencesTable,
          CrossReferenceRow
        > {
  $$CrossReferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$LogoiDatabase db) =>
      db.projects.createAlias('cross_references__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _sourceDocIdTable(_$LogoiDatabase db) => db.documents
      .createAlias('cross_references__source_doc_id__documents__id');

  $$DocumentsTableProcessedTableManager get sourceDocId {
    final $_column = $_itemColumn<String>('source_doc_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceDocIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _targetDocIdTable(_$LogoiDatabase db) => db.documents
      .createAlias('cross_references__target_doc_id__documents__id');

  $$DocumentsTableProcessedTableManager get targetDocId {
    final $_column = $_itemColumn<String>('target_doc_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetDocIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CrossReferencesTableFilterComposer
    extends Composer<_$LogoiDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourcePage => $composableBuilder(
    column: $table.sourcePage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetPage => $composableBuilder(
    column: $table.targetPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceOrigin => $composableBuilder(
    column: $table.sourceOrigin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get sourceDocId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDocId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get targetDocId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetDocId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CrossReferencesTableOrderingComposer
    extends Composer<_$LogoiDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourcePage => $composableBuilder(
    column: $table.sourcePage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetPage => $composableBuilder(
    column: $table.targetPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceOrigin => $composableBuilder(
    column: $table.sourceOrigin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get sourceDocId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDocId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get targetDocId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetDocId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CrossReferencesTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sourcePage => $composableBuilder(
    column: $table.sourcePage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetPage => $composableBuilder(
    column: $table.targetPage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceOrigin => $composableBuilder(
    column: $table.sourceOrigin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get sourceDocId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceDocId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get targetDocId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetDocId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CrossReferencesTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $CrossReferencesTable,
          CrossReferenceRow,
          $$CrossReferencesTableFilterComposer,
          $$CrossReferencesTableOrderingComposer,
          $$CrossReferencesTableAnnotationComposer,
          $$CrossReferencesTableCreateCompanionBuilder,
          $$CrossReferencesTableUpdateCompanionBuilder,
          (CrossReferenceRow, $$CrossReferencesTableReferences),
          CrossReferenceRow,
          PrefetchHooks Function({
            bool projectId,
            bool sourceDocId,
            bool targetDocId,
          })
        > {
  $$CrossReferencesTableTableManager(
    _$LogoiDatabase db,
    $CrossReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrossReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrossReferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrossReferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> sourceDocId = const Value.absent(),
                Value<int> sourcePage = const Value.absent(),
                Value<String> sourceText = const Value.absent(),
                Value<String> targetDocId = const Value.absent(),
                Value<int> targetPage = const Value.absent(),
                Value<String> targetText = const Value.absent(),
                Value<String> relationType = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<String> sourceOrigin = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CrossReferencesCompanion(
                id: id,
                projectId: projectId,
                sourceDocId: sourceDocId,
                sourcePage: sourcePage,
                sourceText: sourceText,
                targetDocId: targetDocId,
                targetPage: targetPage,
                targetText: targetText,
                relationType: relationType,
                confidence: confidence,
                sourceOrigin: sourceOrigin,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String sourceDocId,
                required int sourcePage,
                required String sourceText,
                required String targetDocId,
                required int targetPage,
                required String targetText,
                required String relationType,
                Value<double?> confidence = const Value.absent(),
                Value<String> sourceOrigin = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CrossReferencesCompanion.insert(
                id: id,
                projectId: projectId,
                sourceDocId: sourceDocId,
                sourcePage: sourcePage,
                sourceText: sourceText,
                targetDocId: targetDocId,
                targetPage: targetPage,
                targetText: targetText,
                relationType: relationType,
                confidence: confidence,
                sourceOrigin: sourceOrigin,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CrossReferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectId = false, sourceDocId = false, targetDocId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$CrossReferencesTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$CrossReferencesTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (sourceDocId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceDocId,
                                    referencedTable:
                                        $$CrossReferencesTableReferences
                                            ._sourceDocIdTable(db),
                                    referencedColumn:
                                        $$CrossReferencesTableReferences
                                            ._sourceDocIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (targetDocId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.targetDocId,
                                    referencedTable:
                                        $$CrossReferencesTableReferences
                                            ._targetDocIdTable(db),
                                    referencedColumn:
                                        $$CrossReferencesTableReferences
                                            ._targetDocIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CrossReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $CrossReferencesTable,
      CrossReferenceRow,
      $$CrossReferencesTableFilterComposer,
      $$CrossReferencesTableOrderingComposer,
      $$CrossReferencesTableAnnotationComposer,
      $$CrossReferencesTableCreateCompanionBuilder,
      $$CrossReferencesTableUpdateCompanionBuilder,
      (CrossReferenceRow, $$CrossReferencesTableReferences),
      CrossReferenceRow,
      PrefetchHooks Function({
        bool projectId,
        bool sourceDocId,
        bool targetDocId,
      })
    >;
typedef $$ChatSessionsTableCreateCompanionBuilder =
    ChatSessionsCompanion Function({
      required String id,
      required String projectId,
      Value<String?> documentId,
      Value<String?> title,
      required String provider,
      required String model,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$ChatSessionsTableUpdateCompanionBuilder =
    ChatSessionsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String?> documentId,
      Value<String?> title,
      Value<String> provider,
      Value<String> model,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$ChatSessionsTableReferences
    extends
        BaseReferences<_$LogoiDatabase, $ChatSessionsTable, ChatSessionRow> {
  $$ChatSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$LogoiDatabase db) =>
      db.projects.createAlias('chat_sessions__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) =>
      db.documents.createAlias('chat_sessions__document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get documentId {
    final $_column = $_itemColumn<String>('document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ChatMessagesTable, List<ChatMessageRow>>
  _chatMessagesRefsTable(_$LogoiDatabase db) => MultiTypedResultKey.fromTable(
    db.chatMessages,
    aliasName: 'chat_sessions__id__chat_messages__session_id',
  );

  $$ChatMessagesTableProcessedTableManager get chatMessagesRefs {
    final manager = $$ChatMessagesTableTableManager(
      $_db,
      $_db.chatMessages,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChatSessionsTableFilterComposer
    extends Composer<_$LogoiDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> chatMessagesRefs(
    Expression<bool> Function($$ChatMessagesTableFilterComposer f) f,
  ) {
    final $$ChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatSessionsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatSessionsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> chatMessagesRefs<T extends Object>(
    Expression<T> Function($$ChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$ChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatSessionsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ChatSessionsTable,
          ChatSessionRow,
          $$ChatSessionsTableFilterComposer,
          $$ChatSessionsTableOrderingComposer,
          $$ChatSessionsTableAnnotationComposer,
          $$ChatSessionsTableCreateCompanionBuilder,
          $$ChatSessionsTableUpdateCompanionBuilder,
          (ChatSessionRow, $$ChatSessionsTableReferences),
          ChatSessionRow,
          PrefetchHooks Function({
            bool projectId,
            bool documentId,
            bool chatMessagesRefs,
          })
        > {
  $$ChatSessionsTableTableManager(_$LogoiDatabase db, $ChatSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatSessionsCompanion(
                id: id,
                projectId: projectId,
                documentId: documentId,
                title: title,
                provider: provider,
                model: model,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                Value<String?> documentId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                required String provider,
                required String model,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ChatSessionsCompanion.insert(
                id: id,
                projectId: projectId,
                documentId: documentId,
                title: title,
                provider: provider,
                model: model,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectId = false,
                documentId = false,
                chatMessagesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (chatMessagesRefs) db.chatMessages,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$ChatSessionsTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$ChatSessionsTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable:
                                        $$ChatSessionsTableReferences
                                            ._documentIdTable(db),
                                    referencedColumn:
                                        $$ChatSessionsTableReferences
                                            ._documentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (chatMessagesRefs)
                        await $_getPrefetchedData<
                          ChatSessionRow,
                          $ChatSessionsTable,
                          ChatMessageRow
                        >(
                          currentTable: table,
                          referencedTable: $$ChatSessionsTableReferences
                              ._chatMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChatSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChatSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ChatSessionsTable,
      ChatSessionRow,
      $$ChatSessionsTableFilterComposer,
      $$ChatSessionsTableOrderingComposer,
      $$ChatSessionsTableAnnotationComposer,
      $$ChatSessionsTableCreateCompanionBuilder,
      $$ChatSessionsTableUpdateCompanionBuilder,
      (ChatSessionRow, $$ChatSessionsTableReferences),
      ChatSessionRow,
      PrefetchHooks Function({
        bool projectId,
        bool documentId,
        bool chatMessagesRefs,
      })
    >;
typedef $$ChatMessagesTableCreateCompanionBuilder =
    ChatMessagesCompanion Function({
      required String id,
      required String sessionId,
      required String role,
      required String content,
      Value<String?> context,
      Value<bool> isCompressed,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$ChatMessagesTableUpdateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> role,
      Value<String> content,
      Value<String?> context,
      Value<bool> isCompressed,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$ChatMessagesTableReferences
    extends
        BaseReferences<_$LogoiDatabase, $ChatMessagesTable, ChatMessageRow> {
  $$ChatMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatSessionsTable _sessionIdTable(_$LogoiDatabase db) => db
      .chatSessions
      .createAlias('chat_messages__session_id__chat_sessions__id');

  $$ChatSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$ChatSessionsTableTableManager(
      $_db,
      $_db.chatSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessagesTableFilterComposer
    extends Composer<_$LogoiDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompressed => $composableBuilder(
    column: $table.isCompressed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ChatSessionsTableFilterComposer get sessionId {
    final $$ChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompressed => $composableBuilder(
    column: $table.isCompressed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChatSessionsTableOrderingComposer get sessionId {
    final $$ChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<bool> get isCompressed => $composableBuilder(
    column: $table.isCompressed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChatSessionsTableAnnotationComposer get sessionId {
    final $$ChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ChatMessagesTable,
          ChatMessageRow,
          $$ChatMessagesTableFilterComposer,
          $$ChatMessagesTableOrderingComposer,
          $$ChatMessagesTableAnnotationComposer,
          $$ChatMessagesTableCreateCompanionBuilder,
          $$ChatMessagesTableUpdateCompanionBuilder,
          (ChatMessageRow, $$ChatMessagesTableReferences),
          ChatMessageRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$ChatMessagesTableTableManager(_$LogoiDatabase db, $ChatMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> context = const Value.absent(),
                Value<bool> isCompressed = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatMessagesCompanion(
                id: id,
                sessionId: sessionId,
                role: role,
                content: content,
                context: context,
                isCompressed: isCompressed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String role,
                required String content,
                Value<String?> context = const Value.absent(),
                Value<bool> isCompressed = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ChatMessagesCompanion.insert(
                id: id,
                sessionId: sessionId,
                role: role,
                content: content,
                context: context,
                isCompressed: isCompressed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$ChatMessagesTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$ChatMessagesTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ChatMessagesTable,
      ChatMessageRow,
      $$ChatMessagesTableFilterComposer,
      $$ChatMessagesTableOrderingComposer,
      $$ChatMessagesTableAnnotationComposer,
      $$ChatMessagesTableCreateCompanionBuilder,
      $$ChatMessagesTableUpdateCompanionBuilder,
      (ChatMessageRow, $$ChatMessagesTableReferences),
      ChatMessageRow,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$AiProvidersTableCreateCompanionBuilder =
    AiProvidersCompanion Function({
      required String id,
      required String name,
      Value<bool> isActive,
      Value<String?> baseUrl,
      Value<String?> models,
      Value<String?> settings,
      Value<int> rowid,
    });
typedef $$AiProvidersTableUpdateCompanionBuilder =
    AiProvidersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<bool> isActive,
      Value<String?> baseUrl,
      Value<String?> models,
      Value<String?> settings,
      Value<int> rowid,
    });

class $$AiProvidersTableFilterComposer
    extends Composer<_$LogoiDatabase, $AiProvidersTable> {
  $$AiProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get models => $composableBuilder(
    column: $table.models,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settings => $composableBuilder(
    column: $table.settings,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiProvidersTableOrderingComposer
    extends Composer<_$LogoiDatabase, $AiProvidersTable> {
  $$AiProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get models => $composableBuilder(
    column: $table.models,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settings => $composableBuilder(
    column: $table.settings,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiProvidersTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $AiProvidersTable> {
  $$AiProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get models =>
      $composableBuilder(column: $table.models, builder: (column) => column);

  GeneratedColumn<String> get settings =>
      $composableBuilder(column: $table.settings, builder: (column) => column);
}

class $$AiProvidersTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $AiProvidersTable,
          AiProviderRow,
          $$AiProvidersTableFilterComposer,
          $$AiProvidersTableOrderingComposer,
          $$AiProvidersTableAnnotationComposer,
          $$AiProvidersTableCreateCompanionBuilder,
          $$AiProvidersTableUpdateCompanionBuilder,
          (
            AiProviderRow,
            BaseReferences<_$LogoiDatabase, $AiProvidersTable, AiProviderRow>,
          ),
          AiProviderRow,
          PrefetchHooks Function()
        > {
  $$AiProvidersTableTableManager(_$LogoiDatabase db, $AiProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> baseUrl = const Value.absent(),
                Value<String?> models = const Value.absent(),
                Value<String?> settings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProvidersCompanion(
                id: id,
                name: name,
                isActive: isActive,
                baseUrl: baseUrl,
                models: models,
                settings: settings,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<String?> baseUrl = const Value.absent(),
                Value<String?> models = const Value.absent(),
                Value<String?> settings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProvidersCompanion.insert(
                id: id,
                name: name,
                isActive: isActive,
                baseUrl: baseUrl,
                models: models,
                settings: settings,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $AiProvidersTable,
      AiProviderRow,
      $$AiProvidersTableFilterComposer,
      $$AiProvidersTableOrderingComposer,
      $$AiProvidersTableAnnotationComposer,
      $$AiProvidersTableCreateCompanionBuilder,
      $$AiProvidersTableUpdateCompanionBuilder,
      (
        AiProviderRow,
        BaseReferences<_$LogoiDatabase, $AiProvidersTable, AiProviderRow>,
      ),
      AiProviderRow,
      PrefetchHooks Function()
    >;
typedef $$AiResponseCacheTableCreateCompanionBuilder =
    AiResponseCacheCompanion Function({
      required String id,
      required String cacheKey,
      required String inputHash,
      required String aiMode,
      required String promptVersion,
      required String provider,
      required String model,
      required String response,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      required int createdAt,
      required int lastUsedAt,
      Value<int> useCount,
      Value<int> rowid,
    });
typedef $$AiResponseCacheTableUpdateCompanionBuilder =
    AiResponseCacheCompanion Function({
      Value<String> id,
      Value<String> cacheKey,
      Value<String> inputHash,
      Value<String> aiMode,
      Value<String> promptVersion,
      Value<String> provider,
      Value<String> model,
      Value<String> response,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      Value<int> createdAt,
      Value<int> lastUsedAt,
      Value<int> useCount,
      Value<int> rowid,
    });

class $$AiResponseCacheTableFilterComposer
    extends Composer<_$LogoiDatabase, $AiResponseCacheTable> {
  $$AiResponseCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputHash => $composableBuilder(
    column: $table.inputHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiMode => $composableBuilder(
    column: $table.aiMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get useCount => $composableBuilder(
    column: $table.useCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiResponseCacheTableOrderingComposer
    extends Composer<_$LogoiDatabase, $AiResponseCacheTable> {
  $$AiResponseCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputHash => $composableBuilder(
    column: $table.inputHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiMode => $composableBuilder(
    column: $table.aiMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get useCount => $composableBuilder(
    column: $table.useCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiResponseCacheTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $AiResponseCacheTable> {
  $$AiResponseCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get inputHash =>
      $composableBuilder(column: $table.inputHash, builder: (column) => column);

  GeneratedColumn<String> get aiMode =>
      $composableBuilder(column: $table.aiMode, builder: (column) => column);

  GeneratedColumn<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get useCount =>
      $composableBuilder(column: $table.useCount, builder: (column) => column);
}

class $$AiResponseCacheTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $AiResponseCacheTable,
          AiResponseCacheRow,
          $$AiResponseCacheTableFilterComposer,
          $$AiResponseCacheTableOrderingComposer,
          $$AiResponseCacheTableAnnotationComposer,
          $$AiResponseCacheTableCreateCompanionBuilder,
          $$AiResponseCacheTableUpdateCompanionBuilder,
          (
            AiResponseCacheRow,
            BaseReferences<
              _$LogoiDatabase,
              $AiResponseCacheTable,
              AiResponseCacheRow
            >,
          ),
          AiResponseCacheRow,
          PrefetchHooks Function()
        > {
  $$AiResponseCacheTableTableManager(
    _$LogoiDatabase db,
    $AiResponseCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiResponseCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiResponseCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiResponseCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cacheKey = const Value.absent(),
                Value<String> inputHash = const Value.absent(),
                Value<String> aiMode = const Value.absent(),
                Value<String> promptVersion = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> response = const Value.absent(),
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> lastUsedAt = const Value.absent(),
                Value<int> useCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiResponseCacheCompanion(
                id: id,
                cacheKey: cacheKey,
                inputHash: inputHash,
                aiMode: aiMode,
                promptVersion: promptVersion,
                provider: provider,
                model: model,
                response: response,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                createdAt: createdAt,
                lastUsedAt: lastUsedAt,
                useCount: useCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cacheKey,
                required String inputHash,
                required String aiMode,
                required String promptVersion,
                required String provider,
                required String model,
                required String response,
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                required int createdAt,
                required int lastUsedAt,
                Value<int> useCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiResponseCacheCompanion.insert(
                id: id,
                cacheKey: cacheKey,
                inputHash: inputHash,
                aiMode: aiMode,
                promptVersion: promptVersion,
                provider: provider,
                model: model,
                response: response,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                createdAt: createdAt,
                lastUsedAt: lastUsedAt,
                useCount: useCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiResponseCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $AiResponseCacheTable,
      AiResponseCacheRow,
      $$AiResponseCacheTableFilterComposer,
      $$AiResponseCacheTableOrderingComposer,
      $$AiResponseCacheTableAnnotationComposer,
      $$AiResponseCacheTableCreateCompanionBuilder,
      $$AiResponseCacheTableUpdateCompanionBuilder,
      (
        AiResponseCacheRow,
        BaseReferences<
          _$LogoiDatabase,
          $AiResponseCacheTable,
          AiResponseCacheRow
        >,
      ),
      AiResponseCacheRow,
      PrefetchHooks Function()
    >;
typedef $$ApiUsageLogTableCreateCompanionBuilder =
    ApiUsageLogCompanion Function({
      required String id,
      Value<String?> projectId,
      Value<String?> documentId,
      required String provider,
      required String model,
      required String feature,
      required int inputTokens,
      required int outputTokens,
      Value<bool> cacheHit,
      Value<double?> costUsd,
      required int calledAt,
      Value<int> rowid,
    });
typedef $$ApiUsageLogTableUpdateCompanionBuilder =
    ApiUsageLogCompanion Function({
      Value<String> id,
      Value<String?> projectId,
      Value<String?> documentId,
      Value<String> provider,
      Value<String> model,
      Value<String> feature,
      Value<int> inputTokens,
      Value<int> outputTokens,
      Value<bool> cacheHit,
      Value<double?> costUsd,
      Value<int> calledAt,
      Value<int> rowid,
    });

final class $$ApiUsageLogTableReferences
    extends BaseReferences<_$LogoiDatabase, $ApiUsageLogTable, ApiUsageLogRow> {
  $$ApiUsageLogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$LogoiDatabase db) =>
      db.projects.createAlias('api_usage_log__project_id__projects__id');

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<String>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) =>
      db.documents.createAlias('api_usage_log__document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get documentId {
    final $_column = $_itemColumn<String>('document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ApiUsageLogTableFilterComposer
    extends Composer<_$LogoiDatabase, $ApiUsageLogTable> {
  $$ApiUsageLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feature => $composableBuilder(
    column: $table.feature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cacheHit => $composableBuilder(
    column: $table.cacheHit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costUsd => $composableBuilder(
    column: $table.costUsd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calledAt => $composableBuilder(
    column: $table.calledAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApiUsageLogTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ApiUsageLogTable> {
  $$ApiUsageLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feature => $composableBuilder(
    column: $table.feature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cacheHit => $composableBuilder(
    column: $table.cacheHit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costUsd => $composableBuilder(
    column: $table.costUsd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calledAt => $composableBuilder(
    column: $table.calledAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApiUsageLogTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ApiUsageLogTable> {
  $$ApiUsageLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get feature =>
      $composableBuilder(column: $table.feature, builder: (column) => column);

  GeneratedColumn<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cacheHit =>
      $composableBuilder(column: $table.cacheHit, builder: (column) => column);

  GeneratedColumn<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => column);

  GeneratedColumn<int> get calledAt =>
      $composableBuilder(column: $table.calledAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApiUsageLogTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ApiUsageLogTable,
          ApiUsageLogRow,
          $$ApiUsageLogTableFilterComposer,
          $$ApiUsageLogTableOrderingComposer,
          $$ApiUsageLogTableAnnotationComposer,
          $$ApiUsageLogTableCreateCompanionBuilder,
          $$ApiUsageLogTableUpdateCompanionBuilder,
          (ApiUsageLogRow, $$ApiUsageLogTableReferences),
          ApiUsageLogRow,
          PrefetchHooks Function({bool projectId, bool documentId})
        > {
  $$ApiUsageLogTableTableManager(_$LogoiDatabase db, $ApiUsageLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApiUsageLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApiUsageLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApiUsageLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> feature = const Value.absent(),
                Value<int> inputTokens = const Value.absent(),
                Value<int> outputTokens = const Value.absent(),
                Value<bool> cacheHit = const Value.absent(),
                Value<double?> costUsd = const Value.absent(),
                Value<int> calledAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApiUsageLogCompanion(
                id: id,
                projectId: projectId,
                documentId: documentId,
                provider: provider,
                model: model,
                feature: feature,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                cacheHit: cacheHit,
                costUsd: costUsd,
                calledAt: calledAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> projectId = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                required String provider,
                required String model,
                required String feature,
                required int inputTokens,
                required int outputTokens,
                Value<bool> cacheHit = const Value.absent(),
                Value<double?> costUsd = const Value.absent(),
                required int calledAt,
                Value<int> rowid = const Value.absent(),
              }) => ApiUsageLogCompanion.insert(
                id: id,
                projectId: projectId,
                documentId: documentId,
                provider: provider,
                model: model,
                feature: feature,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                cacheHit: cacheHit,
                costUsd: costUsd,
                calledAt: calledAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ApiUsageLogTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$ApiUsageLogTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$ApiUsageLogTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$ApiUsageLogTableReferences
                                    ._documentIdTable(db),
                                referencedColumn: $$ApiUsageLogTableReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ApiUsageLogTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ApiUsageLogTable,
      ApiUsageLogRow,
      $$ApiUsageLogTableFilterComposer,
      $$ApiUsageLogTableOrderingComposer,
      $$ApiUsageLogTableAnnotationComposer,
      $$ApiUsageLogTableCreateCompanionBuilder,
      $$ApiUsageLogTableUpdateCompanionBuilder,
      (ApiUsageLogRow, $$ApiUsageLogTableReferences),
      ApiUsageLogRow,
      PrefetchHooks Function({bool projectId, bool documentId})
    >;
typedef $$ReadingSessionsTableCreateCompanionBuilder =
    ReadingSessionsCompanion Function({
      required String id,
      required String documentId,
      required int startPage,
      required int endPage,
      Value<int?> durationS,
      required int startedAt,
      Value<int?> endedAt,
      Value<int> rowid,
    });
typedef $$ReadingSessionsTableUpdateCompanionBuilder =
    ReadingSessionsCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> startPage,
      Value<int> endPage,
      Value<int?> durationS,
      Value<int> startedAt,
      Value<int?> endedAt,
      Value<int> rowid,
    });

final class $$ReadingSessionsTableReferences
    extends
        BaseReferences<
          _$LogoiDatabase,
          $ReadingSessionsTable,
          ReadingSessionRow
        > {
  $$ReadingSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentsTable _documentIdTable(_$LogoiDatabase db) =>
      db.documents.createAlias('reading_sessions__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingSessionsTableFilterComposer
    extends Composer<_$LogoiDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startPage => $composableBuilder(
    column: $table.startPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endPage => $composableBuilder(
    column: $table.endPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingSessionsTableOrderingComposer
    extends Composer<_$LogoiDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startPage => $composableBuilder(
    column: $table.startPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endPage => $composableBuilder(
    column: $table.endPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingSessionsTableAnnotationComposer
    extends Composer<_$LogoiDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startPage =>
      $composableBuilder(column: $table.startPage, builder: (column) => column);

  GeneratedColumn<int> get endPage =>
      $composableBuilder(column: $table.endPage, builder: (column) => column);

  GeneratedColumn<int> get durationS =>
      $composableBuilder(column: $table.durationS, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingSessionsTableTableManager
    extends
        RootTableManager<
          _$LogoiDatabase,
          $ReadingSessionsTable,
          ReadingSessionRow,
          $$ReadingSessionsTableFilterComposer,
          $$ReadingSessionsTableOrderingComposer,
          $$ReadingSessionsTableAnnotationComposer,
          $$ReadingSessionsTableCreateCompanionBuilder,
          $$ReadingSessionsTableUpdateCompanionBuilder,
          (ReadingSessionRow, $$ReadingSessionsTableReferences),
          ReadingSessionRow,
          PrefetchHooks Function({bool documentId})
        > {
  $$ReadingSessionsTableTableManager(
    _$LogoiDatabase db,
    $ReadingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> startPage = const Value.absent(),
                Value<int> endPage = const Value.absent(),
                Value<int?> durationS = const Value.absent(),
                Value<int> startedAt = const Value.absent(),
                Value<int?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingSessionsCompanion(
                id: id,
                documentId: documentId,
                startPage: startPage,
                endPage: endPage,
                durationS: durationS,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int startPage,
                required int endPage,
                Value<int?> durationS = const Value.absent(),
                required int startedAt,
                Value<int?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingSessionsCompanion.insert(
                id: id,
                documentId: documentId,
                startPage: startPage,
                endPage: endPage,
                durationS: durationS,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReadingSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable:
                                    $$ReadingSessionsTableReferences
                                        ._documentIdTable(db),
                                referencedColumn:
                                    $$ReadingSessionsTableReferences
                                        ._documentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LogoiDatabase,
      $ReadingSessionsTable,
      ReadingSessionRow,
      $$ReadingSessionsTableFilterComposer,
      $$ReadingSessionsTableOrderingComposer,
      $$ReadingSessionsTableAnnotationComposer,
      $$ReadingSessionsTableCreateCompanionBuilder,
      $$ReadingSessionsTableUpdateCompanionBuilder,
      (ReadingSessionRow, $$ReadingSessionsTableReferences),
      ReadingSessionRow,
      PrefetchHooks Function({bool documentId})
    >;

class $LogoiDatabaseManager {
  final _$LogoiDatabase _db;
  $LogoiDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$PageContentsTableTableManager get pageContents =>
      $$PageContentsTableTableManager(_db, _db.pageContents);
  $$ParagraphsTableTableManager get paragraphs =>
      $$ParagraphsTableTableManager(_db, _db.paragraphs);
  $$ParagraphEmbeddingsTableTableManager get paragraphEmbeddings =>
      $$ParagraphEmbeddingsTableTableManager(_db, _db.paragraphEmbeddings);
  $$DocumentStructureTableTableManager get documentStructure =>
      $$DocumentStructureTableTableManager(_db, _db.documentStructure);
  $$SectionSummariesTableTableManager get sectionSummaries =>
      $$SectionSummariesTableTableManager(_db, _db.sectionSummaries);
  $$AnnotationsTableTableManager get annotations =>
      $$AnnotationsTableTableManager(_db, _db.annotations);
  $$AnnotationVersionsTableTableManager get annotationVersions =>
      $$AnnotationVersionsTableTableManager(_db, _db.annotationVersions);
  $$NotebooksTableTableManager get notebooks =>
      $$NotebooksTableTableManager(_db, _db.notebooks);
  $$ConceptsTableTableManager get concepts =>
      $$ConceptsTableTableManager(_db, _db.concepts);
  $$ConceptRelationsTableTableManager get conceptRelations =>
      $$ConceptRelationsTableTableManager(_db, _db.conceptRelations);
  $$CrossReferencesTableTableManager get crossReferences =>
      $$CrossReferencesTableTableManager(_db, _db.crossReferences);
  $$ChatSessionsTableTableManager get chatSessions =>
      $$ChatSessionsTableTableManager(_db, _db.chatSessions);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$AiProvidersTableTableManager get aiProviders =>
      $$AiProvidersTableTableManager(_db, _db.aiProviders);
  $$AiResponseCacheTableTableManager get aiResponseCache =>
      $$AiResponseCacheTableTableManager(_db, _db.aiResponseCache);
  $$ApiUsageLogTableTableManager get apiUsageLog =>
      $$ApiUsageLogTableTableManager(_db, _db.apiUsageLog);
  $$ReadingSessionsTableTableManager get readingSessions =>
      $$ReadingSessionsTableTableManager(_db, _db.readingSessions);
}
