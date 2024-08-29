// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskEntityCollection on Isar {
  IsarCollection<TaskEntity> get taskEntitys => this.collection();
}

const TaskEntitySchema = CollectionSchema(
  name: r'TaskEntity',
  id: -2911998186285533288,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'dateTimeData': PropertySchema(
      id: 1,
      name: r'dateTimeData',
      type: IsarType.object,
      target: r'TaskEntityDateTimeData',
    ),
    r'important': PropertySchema(
      id: 2,
      name: r'important',
      type: IsarType.bool,
    ),
    r'notate': PropertySchema(
      id: 3,
      name: r'notate',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _taskEntityEstimateSize,
  serialize: _taskEntitySerialize,
  deserialize: _taskEntityDeserialize,
  deserializeProp: _taskEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'category': LinkSchema(
      id: 8847283037907089969,
      name: r'category',
      target: r'CategoryEntity',
      single: true,
    )
  },
  embeddedSchemas: {r'TaskEntityDateTimeData': TaskEntityDateTimeDataSchema},
  getId: _taskEntityGetId,
  getLinks: _taskEntityGetLinks,
  attach: _taskEntityAttach,
  version: '3.1.0+1',
);

int _taskEntityEstimateSize(
  TaskEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.dateTimeData;
    if (value != null) {
      bytesCount += 3 +
          TaskEntityDateTimeDataSchema.estimateSize(
              value, allOffsets[TaskEntityDateTimeData]!, allOffsets);
    }
  }
  {
    final value = object.notate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _taskEntitySerialize(
  TaskEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeObject<TaskEntityDateTimeData>(
    offsets[1],
    allOffsets,
    TaskEntityDateTimeDataSchema.serialize,
    object.dateTimeData,
  );
  writer.writeBool(offsets[2], object.important);
  writer.writeString(offsets[3], object.notate);
  writer.writeString(offsets[4], object.title);
}

TaskEntity _taskEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskEntity(
    title: reader.readString(offsets[4]),
  );
  object.color = reader.readLongOrNull(offsets[0]);
  object.dateTimeData = reader.readObjectOrNull<TaskEntityDateTimeData>(
    offsets[1],
    TaskEntityDateTimeDataSchema.deserialize,
    allOffsets,
  );
  object.id = id;
  object.important = reader.readBool(offsets[2]);
  object.notate = reader.readStringOrNull(offsets[3]);
  return object;
}

P _taskEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<TaskEntityDateTimeData>(
        offset,
        TaskEntityDateTimeDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taskEntityGetId(TaskEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskEntityGetLinks(TaskEntity object) {
  return [object.category];
}

void _taskEntityAttach(IsarCollection<dynamic> col, Id id, TaskEntity object) {
  object.id = id;
  object.category
      .attach(col, col.isar.collection<CategoryEntity>(), r'category', id);
}

extension TaskEntityQueryWhereSort
    on QueryBuilder<TaskEntity, TaskEntity, QWhere> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TaskEntityQueryWhere
    on QueryBuilder<TaskEntity, TaskEntity, QWhereClause> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskEntityQueryFilter
    on QueryBuilder<TaskEntity, TaskEntity, QFilterCondition> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      dateTimeDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateTimeData',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      dateTimeDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateTimeData',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> importantEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'important',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notate',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notate',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notate',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notate',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension TaskEntityQueryObject
    on QueryBuilder<TaskEntity, TaskEntity, QFilterCondition> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> dateTimeData(
      FilterQuery<TaskEntityDateTimeData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dateTimeData');
    });
  }
}

extension TaskEntityQueryLinks
    on QueryBuilder<TaskEntity, TaskEntity, QFilterCondition> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> category(
      FilterQuery<CategoryEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'category');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'category', 0, true, 0, true);
    });
  }
}

extension TaskEntityQuerySortBy
    on QueryBuilder<TaskEntity, TaskEntity, QSortBy> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByNotate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByNotateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TaskEntityQuerySortThenBy
    on QueryBuilder<TaskEntity, TaskEntity, QSortThenBy> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByNotate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByNotateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TaskEntityQueryWhereDistinct
    on QueryBuilder<TaskEntity, TaskEntity, QDistinct> {
  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'important');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByNotate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension TaskEntityQueryProperty
    on QueryBuilder<TaskEntity, TaskEntity, QQueryProperty> {
  QueryBuilder<TaskEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TaskEntity, int?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<TaskEntity, TaskEntityDateTimeData?, QQueryOperations>
      dateTimeDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTimeData');
    });
  }

  QueryBuilder<TaskEntity, bool, QQueryOperations> importantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'important');
    });
  }

  QueryBuilder<TaskEntity, String?, QQueryOperations> notateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notate');
    });
  }

  QueryBuilder<TaskEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TaskEntityDateTimeDataSchema = Schema(
  name: r'TaskEntityDateTimeData',
  id: -6856039928482930222,
  properties: {
    r'endDateOfRepeadetly': PropertySchema(
      id: 0,
      name: r'endDateOfRepeadetly',
      type: IsarType.dateTime,
    ),
    r'isRepeatedly': PropertySchema(
      id: 1,
      name: r'isRepeatedly',
      type: IsarType.bool,
    ),
    r'isTime': PropertySchema(
      id: 2,
      name: r'isTime',
      type: IsarType.bool,
    ),
    r'repeatDuringDay': PropertySchema(
      id: 3,
      name: r'repeatDuringDay',
      type: IsarType.dateTimeList,
    ),
    r'repeatDuringWeek': PropertySchema(
      id: 4,
      name: r'repeatDuringWeek',
      type: IsarType.boolList,
    ),
    r'taskDate': PropertySchema(
      id: 5,
      name: r'taskDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _taskEntityDateTimeDataEstimateSize,
  serialize: _taskEntityDateTimeDataSerialize,
  deserialize: _taskEntityDateTimeDataDeserialize,
  deserializeProp: _taskEntityDateTimeDataDeserializeProp,
);

int _taskEntityDateTimeDataEstimateSize(
  TaskEntityDateTimeData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.repeatDuringDay;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.repeatDuringWeek;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  return bytesCount;
}

void _taskEntityDateTimeDataSerialize(
  TaskEntityDateTimeData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.endDateOfRepeadetly);
  writer.writeBool(offsets[1], object.isRepeatedly);
  writer.writeBool(offsets[2], object.isTime);
  writer.writeDateTimeList(offsets[3], object.repeatDuringDay);
  writer.writeBoolList(offsets[4], object.repeatDuringWeek);
  writer.writeDateTime(offsets[5], object.taskDate);
}

TaskEntityDateTimeData _taskEntityDateTimeDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskEntityDateTimeData();
  object.endDateOfRepeadetly = reader.readDateTimeOrNull(offsets[0]);
  object.isRepeatedly = reader.readBool(offsets[1]);
  object.isTime = reader.readBool(offsets[2]);
  object.repeatDuringDay = reader.readDateTimeList(offsets[3]);
  object.repeatDuringWeek = reader.readBoolList(offsets[4]);
  object.taskDate = reader.readDateTimeOrNull(offsets[5]);
  return object;
}

P _taskEntityDateTimeDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDateTimeList(offset)) as P;
    case 4:
      return (reader.readBoolList(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TaskEntityDateTimeDataQueryFilter on QueryBuilder<
    TaskEntityDateTimeData, TaskEntityDateTimeData, QFilterCondition> {
  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> endDateOfRepeadetlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDateOfRepeadetly',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> endDateOfRepeadetlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDateOfRepeadetly',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> endDateOfRepeadetlyEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDateOfRepeadetly',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> endDateOfRepeadetlyGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDateOfRepeadetly',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> endDateOfRepeadetlyLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDateOfRepeadetly',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> endDateOfRepeadetlyBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDateOfRepeadetly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> isRepeatedlyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRepeatedly',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> isTimeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayElementEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayElementGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayElementLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayElementBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatDuringDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringDayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repeatDuringWeek',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repeatDuringWeek',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDuringWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> repeatDuringWeekLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> taskDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'taskDate',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> taskDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'taskDate',
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> taskDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> taskDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> taskDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntityDateTimeData, TaskEntityDateTimeData,
      QAfterFilterCondition> taskDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskEntityDateTimeDataQueryObject on QueryBuilder<
    TaskEntityDateTimeData, TaskEntityDateTimeData, QFilterCondition> {}
