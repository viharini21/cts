import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Store } from '@ngrx/store';

import { CourseCard } from '../../components/course-card/course-card';
import { Course } from '../../models/course.model';
import { loadCourses } from '../../store/course/course.actions';
import {
  selectAllCourses,
  selectCoursesError,
  selectCoursesLoading,
} from '../../store/course/course.selectors';

@Component({
  selector: 'app-course-list',
  imports: [CommonModule, FormsModule, CourseCard],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css',
})
export class CourseList implements OnInit {
  courses: Course[] = [];
  selectedCourseId: number | null = null;
  isLoading = true;
  errorMessage = '';
  searchTerm = '';

  constructor(
    private readonly store: Store,
    private readonly router: Router,
    private readonly route: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.searchTerm = this.route.snapshot.queryParamMap.get('search') ?? '';

    this.store.dispatch(loadCourses());
    this.store.select(selectAllCourses).subscribe((courses) => {
      this.courses = courses;
    });
    this.store.select(selectCoursesLoading).subscribe((loading) => {
      this.isLoading = loading;
    });
    this.store.select(selectCoursesError).subscribe((error) => {
      this.errorMessage = error ?? '';
    });
  }

  onEnroll(courseId: number): void {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;
  }

  navigateToCourse(courseId: number): void {
    this.router.navigate(['courses', courseId]);
  }

  onSearchChange(): void {
    this.router.navigate(['courses'], {
      queryParams: { search: this.searchTerm || null },
    });
  }

  // trackBy prevents full re-rendering of list DOM nodes when only one item changes.
  trackByCourseId(_index: number, course: Course): number {
    return course.id;
  }
}
